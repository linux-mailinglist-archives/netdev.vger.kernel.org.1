Return-Path: <netdev+bounces-284546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF6MN/I1+mlLKwMAu9opvQ
	(envelope-from <netdev+bounces-284546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:24:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 860794D29CF
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F8830B6D55
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5FE4ADD88;
	Tue,  5 May 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NrEis/xt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF174A341B
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005385; cv=none; b=nD6AjinKnmpbOujZjbQLK0eRvymDjFRE5E8SVpvu/euATppLk6618V7UGldDJRdJpz/vLqKkS9o4ORDoXOB2D7G1GQ1IokV9RODmyS80/GYxJRO3ssPOh3mMZZ0dM17eS06+8zX7yCNAFdTtZZLAX3vCjrzmoIYhEza+9Hf8vqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005385; c=relaxed/simple;
	bh=GgkkRdICe7DfLGShMiCKE1jBH4nLY83u4kIozlYXyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByJ30zyweugXJ7XcuL9WtiGR0FszsawDNutSACI+i/YYzmzBcEkmK3EughHJPJVJrpsNqDMH31R6pL0cPXsgtDO8WyvuuPK2bkza8Hf6/7oU4vYLcH5yynzcSwBZCqS9SR6g1pSMyvewB27l/HGmpFz+fG1LWcmLtOksJtyI25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NrEis/xt; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-35fb262f92cso1247554a91.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005383; x=1778610183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TctQ/QPTybZnX6Hj/EaRyQr5V49De/CNOWCLe2wy8Y=;
        b=kZCCcIfR4PTMWTyBlbDOey41aBW3v4axtTe8fjt+MMQGI4V1ohuhNeAWWO5qTVYSiz
         4r/nz0r9U/1kk7VHgrU6R6GA14rzTX5vGg19XOeg7Xcs+YxzUxdY54m2tO3o/flJrTS4
         yG0jV4iBob3XMO1eRX6TJKV95M8R3BhNobtMHRlEjf81kkmJqp7/EDSm4TqO0cZricEg
         WU8JIBiy7sz2qGUAc9wU2ioHCZKvdJHZgZOqkedMb7fu0TJNLP/ULGOhBPG6clkJGOeH
         ZlpIlNXpY9SXab+0rFTooakr5+YAsQeENuk+9oVDrpzDJcvGLzdzhxmJYHnVx82MioRU
         TMCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FRaPhearJQSjsMT+bq6Rk9uNcZEsLS0+/o2DlSmrsTj+78OdGusLP9lDodeLnOIelIcsnPyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGTXthK3yhd3UYDUYqIusuBF6+YMs/7jdTDJ1Q1gwpR9dHbag
	GRVgCOp4swJMvbDXeWmKjrRFTRyQAAnEw3lRcL/SJVTnymGXuClQUC6dRYAKP5vy8AIjp4BjqYE
	EoICFsREOHB/daD323Vmx3r7R4WLsQnQ22RLxvLZAptsRLy7Z0G0Dhh+sPL3v/BrQ+EqhOnjTog
	N3UuBE1XZL0oXkHkP0MP85ES2qDPOcdZdu4iJfWNLdPgCvLVJEtlDQC+QiHoTPJPt7i+WcBQ3Oy
	GSqvgUsfvAjH4c=
X-Gm-Gg: AeBDieuFVf5wCoCmhxehjcA9wUTjBhKTPlqQ+QLtiQ2fvveLPtett6Mvsv4LHiERfsT
	ox5r+d60Ek8Bn3ZhSj2P/EOSA7rDVVOstAHlCpI3M0nYUxy9+tVXl41cGTkl/1WlxMjCAnR4UfN
	juBmH0mFbh4Pmp3F2ULwKgSecKR3JrT72+vfQJ75q/nS6LqPnrtqRSrDhtorUUeMUylrkBVw3To
	Ce24QgDBmv3rYvJlyarCGmabMtBECEJqp+tBcjsNKmFkkeM/LfXGZP5hWhqiCUe3YoNQZ9iQ9pO
	92lmXbLnEhsZQfPeqILpOLrfo5UJjAs+aIMxfeIiiF53bCeOV1Izg8Y9wqFpet2RNEOBRn8aMOn
	vcYqeF0d5oe8qcyGLdWgjh20yDy4ZZ0R1sYntScVgqDAIasZtX+/UJWAOaQJhKkCZQSmVyClSdQ
	pPZEiLs7FRsQLj7th3YQnC7T2sW2pv167ui6VhG7s6p0PkXOeqfZFThRtS3PD2hrchgPvc
X-Received: by 2002:a05:6a21:511:b0:394:5c62:4601 with SMTP id adf61e73a8af0-3aa5a923e0cmr27344637.4.1778005383088;
        Tue, 05 May 2026 11:23:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c7ffbbffecbsm826960a12.3.2026.05.05.11.23.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 11:23:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f218ed8dc3so357653eec.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778005381; x=1778610181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TctQ/QPTybZnX6Hj/EaRyQr5V49De/CNOWCLe2wy8Y=;
        b=NrEis/xtmnglfuGIcyTfkn8ADKQMxf6244eE9z9S+E4vQPasph6o2JwPV6RqAM/3X/
         DQLA2lRG3pChrNzLYyq6OH1+6JfHKrMRRA9YHHfVORcf3DuuwGVD63BBi2nj8i4s3TVJ
         eOh2X2heusNCQRCY5h+sw/EsDEpSD3YgHBrP4=
X-Forwarded-Encrypted: i=1; AFNElJ98LxaioV0pdUEUrXt5+rY9eGZFafZiC48PCkYTDVQ6WU7QafMLkHaonUCcVujiw/C3U51jQQU=@vger.kernel.org
X-Received: by 2002:a05:7022:68a6:b0:12b:f899:7178 with SMTP id a92af1059eb24-1318eb48053mr80655c88.7.1778005380599;
        Tue, 05 May 2026 11:23:00 -0700 (PDT)
X-Received: by 2002:a05:7022:68a6:b0:12b:f899:7178 with SMTP id a92af1059eb24-1318eb48053mr80643c88.7.1778005379959;
        Tue, 05 May 2026 11:22:59 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8424ef1sm27629462c88.9.2026.05.05.11.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:22:59 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: edumazet@google.com
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: Re: [PATCH net v2 1/2] tcp: protect locked SO_RCVBUF from Silly Window Syndrome
Date: Tue,  5 May 2026 18:19:19 +0000
Message-ID: <20260505181919.15308-1-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANn89iKcaOK6rrY=m0SVfXdx3jTRXCE3T+jNQpw434UZ8oxtpw@mail.gmail.com>
References: <CANn89iKcaOK6rrY=m0SVfXdx3jTRXCE3T+jNQpw434UZ8oxtpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 860794D29CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284546-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi Eric,

Thanks for the review and suggestion.

> Testing tp->advmss is not doing what you want I think.
> 
> A remote peer can send GRO packets with tiny segments, regardless of
> tp->advmss
> 
> If GRO is what you are looking for, why not testing (skb->len > len) ?

I tested your suggested `skb->len > len` logic on our reproduction
setup. It works perfectly and the 504 timeouts are completely resolved.

Thanks,
Ankit

