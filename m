Return-Path: <netdev+bounces-268908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNUbBIJYumnFUgIAu9opvQ
	(envelope-from <netdev+bounces-268908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:47:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D452B7288
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 054D9300C323
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5CB36C0CC;
	Wed, 18 Mar 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9T1rMU8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA536B056
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820029; cv=none; b=cWOsoS/7f4xE5skgKtxz5hB0qetXuXIB/NLvdwRIyKvHQMb7hbeCdPVAOgh94s/Tx6cUTlJniHBOZn0aScnvzix3blmgI9ouz2HnY9oMa5niSIPCYhx9eSw5x0rEnYSVrsXya2/PF03/THoPrBQcFNHPiBe5COxjmH1KgeporvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820029; c=relaxed/simple;
	bh=6AyM+5lJ+dSs+SjiqVmcLVaC5WWE37JafHboRqppUoA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DctZDROsKpvVJImN8EdGK0BMxfwZH9xFyYlzn/Ti0NiTkpOcfHJ+hzGiN6mDtfcxR3pHXbciaTc3W5e0AoJ9DnZolGBcPLavA35OcX+W+o5IE3nJQL5dAbVU6tvWc6xAJydxbYUEUT//s6cmIK079R8jMhYGn6uS/5QtrgD6J4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F9T1rMU8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48541edecf9so71336735e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 00:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773820027; x=1774424827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XdQh/lG6wJGknLC6Mk9SsT+zVzn0gaCcGpcDHBd/XtU=;
        b=F9T1rMU8dGECHgIjfHimC/PRb623nkP3VWY12D2nviLt1rKJ/V0V91f7xBZoscBTzR
         Z95BgkbgU+s3Z8FWJE72VXqz7Qg2Ot7348sH1o4g0MKLLOF9JGsiiIyZAPno6F0z2p6j
         oikPJbJ4kRzGLWHl8+dr2OJo2ZqU0IvJqloYX8ouLGGsKhBm8fssCWYJanXiWyc9fng4
         7e1DRuftQ/M24Khqdxbk588UEisj/6KOjAmS7Qubhczj93q9pqRXpRnZPNToYDL80Tvn
         d01EUQBHV7W6c2o7TdEgJqybLsJia65I3OQGwyqeBd54fEQ2z+8pm6HYutSlh/Pe9rAl
         iFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773820027; x=1774424827;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdQh/lG6wJGknLC6Mk9SsT+zVzn0gaCcGpcDHBd/XtU=;
        b=LpcC5FVeHEJz8vkF4IQ24wgK0jPW1hadLF6twQGVzlOr/z6f+N9qbcpk53xAUoUyfJ
         eic8z9LLEg7UY1J5Z2bIFBdOySbzNSiiRycHkEKcI9trIXTno8Zk32jrqLzFui1efL9n
         l4D594Cl50IubfG08K1bk0+x12DqezqjAUcIdAiwU7ixilCIxDlaxXTUOxUyMl8FkiMl
         0LP1fIzJGtd07fiS5Y1W/S0jMhJewhoMUBlAbei65o21p5as0l1nucOkPKG17YkiP5oK
         gPghVQgFZsylDd11qCpYTZz3ST/2x4Ismc+BjGJKShlX45HE2G24aGbmextU7WD19D6J
         p7ag==
X-Forwarded-Encrypted: i=1; AJvYcCWvtjPgrhko6ha5WmEpBLKM0DTPg1UaLzSa++7yvHo3DYWbHLORehIhSyH6NbBoughoRKEwPrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYklaJSiiO+KcaTv4DZ8mPSxT6K3JLTD5ObOzuZ33tsehe4ad
	qTF6nbNzyU6Rt0jIS0Qex+P+sEUUNQ63uy16yXqC3PyKiTJJt0gJNIyg2lsfXb0KkmQ=
X-Gm-Gg: ATEYQzxwwmXZ8QTiKa6fNitum5PaFwaSoFlPAA3vIDR5GVCj7avm/5s3VaBAlzxNZID
	6RDhIL7ZekV/w/uG/1W0/J1dPptczUge1iM/XAqU9Em9T0VsSIHIfkeO+RgheX+wXQO2YHrELEK
	RXsghh1vNTjowT7JXcFORYk/naGvG6XA24o5SEsZj5y3t6hjUaL4bAOjUPrKBjgvxrz6egCv7/f
	qfzSnJ6+w9gSXryuqw8n26zPd7BwqHBbxqBa2sUqmgMlQGVT1Xbw50LSubkXX+2STLaZ3nLottp
	Z20+OFSPYf8dUYGEqCxp7WHspvIJba2GpSvKeGcFZlV1on+73m1aRWprg9yLJPuF+9tP27mzMkF
	/54TRGJ+fnSOrVEOmBDwFRq23ooNhrouLRXJ9kKze2W5v9QfuKOZ/NFumsqvbBxOsxspqRjYRnw
	WGBJwhe4YgT89uOD+HvRri8yAlsqK2c8ETqqhOPgE=
X-Received: by 2002:a05:600c:c491:b0:485:3f58:d9f with SMTP id 5b1f17b1804b1-486f4465d04mr38125605e9.30.1773820026579;
        Wed, 18 Mar 2026 00:47:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fad1sm216587555e9.1.2026.03.18.00.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:47:06 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:47:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rahul Gupta <rahul-rg.gupta@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next v6 06/10] bng_en: add HW stats infra and
 structured ethtool ops
Message-ID: <202603180509.nOQGZrG0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310144044.21672-7-bhargava.marreddy@broadcom.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268908-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: A9D452B7288
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bhargava,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Bhargava-Marreddy/bng_en-add-per-PF-workqueue-timer-and-slow-path-task/20260310-231948
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260310144044.21672-7-bhargava.marreddy%40broadcom.com
patch subject: [PATCH net-next v6 06/10] bng_en: add HW stats infra and structured ethtool ops
config: arm64-randconfig-r071-20260317 (https://download.01.org/0day-ci/archive/20260318/202603180509.nOQGZrG0-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202603180509.nOQGZrG0-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c:1598 bnge_hwrm_port_qstats_ext() warn: missing error code? 'rc'

vim +/rc +1598 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c

598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1576  	rc = bnge_hwrm_req_init(bd, req_qc, HWRM_QUEUE_PRI2COS_QCFG);
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1577  	if (rc)
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1578  		return rc;
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1579  
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1580  	req_qc->flags = cpu_to_le32(QUEUE_PRI2COS_QCFG_REQ_FLAGS_IVLAN);
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1581  
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1582  	resp_qc = bnge_hwrm_req_hold(bd, req_qc);
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1583  	rc = bnge_hwrm_req_send(bd, req_qc);
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1584  	if (!rc) {
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1585  		u8 *pri2cos;
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1586  		int i, j;
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1587  
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1588  		pri2cos = &resp_qc->pri0_cos_queue_id;
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1589  		for (i = 0; i < 8; i++) {
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1590  			u8 queue_id = pri2cos[i];
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1591  			u8 queue_idx;
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1592  
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1593  			/* Per port queue IDs start from 0, 10, 20, etc */
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1594  			queue_idx = queue_id % 10;
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1595  			if (queue_idx >= BNGE_MAX_QUEUE) {
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1596  				bn->pri2cos_valid = false;
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1597  				bnge_hwrm_req_drop(bd, req_qc);
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10 @1598  				return rc;

return -EINVAL;

598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1599  			}
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1600  			for (j = 0; j < bd->max_q; j++) {
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1601  				if (bd->q_ids[j] == queue_id)
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1602  					bn->pri2cos_idx[i] = queue_idx;
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1603  			}
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1604  		}
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1605  		bn->pri2cos_valid = true;
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1606  	}
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1607  	bnge_hwrm_req_drop(bd, req_qc);
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1608  
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1609  	return rc;
598cdbbcf8f4c1 Bhargava Marreddy 2026-03-10  1610  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


