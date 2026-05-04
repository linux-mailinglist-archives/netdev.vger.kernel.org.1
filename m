Return-Path: <netdev+bounces-283973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEd7FmDa+GnG2QIAu9opvQ
	(envelope-from <netdev+bounces-283973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:41:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEC94C2058
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8558E3025E7E
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 17:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44193E51EF;
	Mon,  4 May 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="FcK7apwI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1A3E4C8C
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916469; cv=none; b=doY7zGYVcyB/k5SserswHt8PTootChBWaj3sfQdpYaZcKRV+omt4F1YMR/na3tGXDCR+57RkCFglOX7qsjjDdvh4d05ruNxz0LhN4H/w1YWOG1F3Q8t1RmBZd+k2IVmrITUTyCfXbNEwkogQbyHbK90PHd6n8msbw/WMEDiC97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916469; c=relaxed/simple;
	bh=kzKsrs0y5jrGnVqBaAyXbt3JJM72U8Ryvc3+DSouO8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhwPIqej+lL+TnQC9uZW37N3WRQMXkwtaxlrmOq3EyXAcOtqw65EpfFBcY/y2FnZQSpTneWcPpPVeTnQvq1va79mQn8mCatQ1t79Hr7aYp+ogzSBm4YlsbpiRkrRTPoBG/ptdOyoTLgz7pBzsEDiDDc2qlODmEIowlr91/qkWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=FcK7apwI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b9ec9443c2so11652835ad.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1777916467; x=1778521267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmJADCUYYJkAP0ynYy9365oRJvMWu6Lq9KoE1sTjfVQ=;
        b=FcK7apwIBG4P45xVGvf2cIRnLYLXNcQKG60EY8EQhnkpCrQzSRFyKVi4Fn417DO6BM
         sqhGzV/IrXn7Mg7pt+oYJbItA0zHAVU3b4Xygp4oe2RGAUY+pCZTeiVtBBklnIRVs8Rp
         IUxTho7TICNZbNrSCDSuIsnahLdBDpFs70m33LI6U8/Y9AlZME0Ac/BEleYl1Y4txgK1
         VgFWVIftkun5nRv3YAtwjQoYuIbu16iG48zD4DOa4/sHaR20AmEiAZ3RXob6JiyRXB0+
         29oW87CNPWXQQJn277B4to1Kim7ZeTSNtBBmE7OxV9Y067YhqtQEiL4eeShVWYWnnXCk
         dC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916467; x=1778521267;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmJADCUYYJkAP0ynYy9365oRJvMWu6Lq9KoE1sTjfVQ=;
        b=kyN42cBsOwe2N17QF+eYs6ukG6Iuik90o5BuD90dRpfMI7R7W1RhnPAsi+vF5UxkVv
         esYBqbo+5N6eC9j9/LCgB6W4liH8VQP9fkbVJFkIMr9PFHQPukggEOiOD26rhRnVQwJz
         mK83nVaeOGTk511h2UbP382vz9zGT7P++hdSDQJXMhBZWDeTOTY8DhWt9i8Rgsl7ReVH
         Y73GPrCiA7ypwXwRAh57adesXdfNiMWLAa/6jeWesQs7qfKdKt6qqku6+Dfh86Vk14M9
         GzSBOiHyjan76kD1Qe53shuzrjHPklXs02eBMcwoUZ+lxdnui/L7r65Jz3G8eeuuVdoB
         UI2A==
X-Forwarded-Encrypted: i=1; AFNElJ8Qcc3f4BCVROiaZd4757hA7XWr+N6MxZ/zubT/aMYDWLUowrx0ymEhX4aiuAWgTz0dq55X910=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0rTrW6YXN0Fp1QWJrKGOOGPzBoJXClwmhwotwE2asZFd589y5
	0QqcCScSsj0j5qbikWnF1mm/aIrQRVNOrdYZv+Ac6U8HYLWxz7VCXt6FFJF0z4aHeYA=
X-Gm-Gg: AeBDievIgn49O0znVal8zESNeQ4iMtA/U691nyVp0lWIQTINl2KoVy/MlDRNjXrNgrF
	HYDrLzrf7CAaN83fBUQ4lq712jGYg1tJoq1BaLAErpzSGekO4q976mscfGvO59tnAGRF0rCMpv8
	jVdP88q+H8Qpea/U612FuyklwnlC1JpGWmkqL02MqxwwH11jVKgVx/MYLvFVlMHyJHAusYtGeCY
	tyopBQOZAzo9n7hdwuU5kYlUhJ3Nj/ucXMmXrPYsULHyzy4HZuiJDw3DPpFzs6kcVkHFgevlwq+
	rQJDqejFeNWywdZjRMrXcgtVaH5m9FwCHtH+aqz5ct/puyOyOnDg8d9vPMO2q8qtj7ktBcSAo0n
	6qaSPbeL+bunnG+rO3x/Ol0nmayDW5rOvwHeiYdc91kObvVNLAh4riMI6TKZR3eDUhOfQ9gcZQ7
	mLd3+AFdowHxKvAQ==
X-Received: by 2002:a17:902:c992:b0:2ae:4ad5:b76c with SMTP id d9443c01a7336-2ba4d7b9de6mr2316725ad.10.1777916466780;
        Mon, 04 May 2026 10:41:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae59f57sm109511655ad.77.2026.05.04.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:41:06 -0700 (PDT)
Date: Mon, 4 May 2026 10:41:05 -0700
From: Joe Damato <joe@dama.to>
To: Jon Kohler <jon@nutanix.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] e1000e: ethtool: add get_channels support
Message-ID: <afjaMXktB3WmT7KC@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Jon Kohler <jon@nutanix.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260504154823.2535612-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504154823.2535612-1-jon@nutanix.com>
X-Rspamd-Queue-Id: ADEC94C2058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283973-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nutanix.com:email,devvm20253.cco0.facebook.com:mid,dama.to:email,dama-to.20251104.gappssmtp.com:dkim]

On Mon, May 04, 2026 at 08:48:23AM -0700, Jon Kohler wrote:
> e1000e hardware supports a single RX/TX queue pair, add basic support
> for ethtool -l (i.e. get_channels), so that callers indeed see a single
> queue.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 26 +++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Joe Damato <joe@dama.to>

