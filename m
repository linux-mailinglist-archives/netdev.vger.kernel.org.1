Return-Path: <netdev+bounces-262381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k9hdNFD+o2lZUAUAu9opvQ
	(envelope-from <netdev+bounces-262381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 09:52:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01F1CEE75
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C9903018099
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99018430B96;
	Sun,  1 Mar 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC6tqmpG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925315539A
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772355149; cv=none; b=msqZOIr/ZFMN8MOQAeM3zqCvH/sNIj27pIERJKj03rEvBGJltXSSYWC0HFmE2hl7NTMdP2ifqBk3HCjGfUH6BDWSlWaHyjJACiRZrxzrXLb9+PMQzhjQ3M71Wl9v5BSUU+mm3hqTt9hjHK0AAgyxx4GYUWD3RpRXmch58Dri7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772355149; c=relaxed/simple;
	bh=GJpcX8Gxu3fGxfkLg5G9RaM7wjzfxC9oJxZIo5UCpSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyU42pzmwcYVhUyatLfGIteHZUvICtsnjJYT25lODUaBzlt5kPwCbOsjV8EhieReto5nnAFEBanF8y56it0sKWZ4JEK5G2Icosp7tgIDKeuVDgMV8PHeQ1SA+Ut0RV6e2sf13+xVxAlQwcIWjXzYW7WNbRSoOnnjS2366YcQ/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC6tqmpG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso28923155e9.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 00:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772355146; x=1772959946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TBO61xL5CrUk+VccUJrq/FWiDp9XAo/yD/ZujB6gzE=;
        b=WC6tqmpGyxe7kTn5uEavkFvPOs0WQIBibL3t+qLJ0/k2xYdAyqoKSCLkkNxNckHFxm
         PiyqtUpR1JN39bLjxfaiYclzJImRdXA2y2NAIB1nWtshuhfESmr6coHhaZSS+aqHR1nn
         2ODt3db6cWi5oZdwiATTKBnjDudElqHmV7xH9g6RofBbEdfAd3RCIf2dpSzYUMGxQvOZ
         DfUlNAbHTuxpKs+OOJ5qwi9+scny6EFa5a3F4kVNTDuwVyIpNxBaePgIsQc66ERkKjur
         NHFWBXkwjtE1sxA4QFGv56AjoXyhlHtFITlZC2EXsAYYsCD/7dAQCtFDgmM5mMiDph94
         HoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772355146; x=1772959946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TBO61xL5CrUk+VccUJrq/FWiDp9XAo/yD/ZujB6gzE=;
        b=QRWqLYVmMbIhMGVR9MnWZ1lvWwDNVFM8Elo0gr1QK1hewvb8E1wFEQGCrkWCRrBejx
         sImuvaYDq+XAFt6jAYy8/2ZW/Haw/08DbkYD3bKpQvrd7+eK178sCnbRh/dWonr3Mxq2
         RXMEf+s42Y9OEvRwQltlUhzUO8IzYlmWrFc76fDDXUl0NSHw3xarPEemMI8C3fhMCeu1
         HBhyDg/6L5phW2n5tuDKgpGbv+hk1/76INHsx6GJxspUFHUHYNN7SK1BKMb13wrq+zhs
         XmCuRphBVYIDgcokcKXlARXLaWZFELmMLCZWmoNrH0Y692ZhkPYDBeUgquAURdm7gljs
         kmlw==
X-Forwarded-Encrypted: i=1; AJvYcCVPKWsQQ8Qav7+ePjxAEykPmKnA067FHTHvtam/lZUbxCrWYzva8U0INE2+iEsQI8w9g5SmBrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLp9tvAatJ0WqE/D9oPtCj2A+8zcHGlk62fgYtl7/xBZfmH+48
	z74V37jbiSBCFDC8tVfTCcs3BcePhBYpcELI4khtZ3ysHE53oxl1tNKC
X-Gm-Gg: ATEYQzyRS3wI/4uWDPV/gqsu4Fgs2jAOks286iK4WeJ/hluVomjif2ZWy0lxaplxpE9
	kQ3gvW0oMFDdYK8StuZAZYEXLgqulQArbKhl9v6ALkvvjQ98W+i0WqYDZPrVclqMyS8izgdwrS7
	6UKA5qX637gU9dUeXN7th0xL+MmC6fvZGQ2UdFJ9scjE+W2KdDUyJYxPx+lbT5jiwtYkD2/VoRI
	86sd9CGsI9Td0MmYjF8m6+bk9HYoevsP3JTwviiDmrfuVB/yNaQftTO9SBPwWLE2V2DH9J17iH0
	QAMOCxMyhyw86MLDq1ZpBte1io6vDlLa1ZFL5qw9ikvQmZeYK7RM4slD9mHIfAT048yloajsJmO
	qh69MQ2uPdWMyNbKWbJ7Qn4J0/RGAdJXADoQJvD53UaMnt3eJMdHIwFjcZ0Tn9Zx+JLeR4MoJCP
	BWBobHcVRVzDbXhDBTIZghhPV9N5xsnUs0VcGfUJdxO5ZYBmok//3jcYQU41Vw01l45cHC/7LB2
	N5MlQrPjjMDETKhO8AGsag=
X-Received: by 2002:a05:600c:1486:b0:483:348a:d3f3 with SMTP id 5b1f17b1804b1-483c9beabf1mr95588785e9.18.1772355146198;
        Sun, 01 Mar 2026 00:52:26 -0800 (PST)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb2c5a8sm153891165e9.0.2026.03.01.00.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 00:52:25 -0800 (PST)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 071B52FED6D6; Sun, 01 Mar 2026 09:52:25 +0100 (CET)
Date: Sun, 1 Mar 2026 09:52:24 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net] selftests/net: packetdrill: remove tests for
 tcp_rcv_*big
Message-ID: <aaP-SGo8GGbDAVI9@gandalf.schnuecks.de>
References: <20260227033446.2596457-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227033446.2596457-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262381-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C01F1CEE75
X-Rspamd-Action: no action

Hi Jakub,

On Thu, Feb 26, 2026 at 07:34:46PM -0800, Jakub Kicinski wrote:
> Since commit 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> has been reverted we need to remove the corresponding tests.

tcp_rcv_big_endseq.pkt actually belongs to a different commit and
needs a small tweak to run again. I have posted a patch at
https://lore.kernel.org/netdev/20260301-tcp_rcv_big_endseq-v1-1-86ab7415ab58@gmail.com/

- Simon

-- 
Simon Baatz <gmbnomis@gmail.com>

