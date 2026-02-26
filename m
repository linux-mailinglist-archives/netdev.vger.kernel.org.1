Return-Path: <netdev+bounces-261331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJugAko/oGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:40:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B11261A5D0C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB4E83066CFE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3B83803CE;
	Thu, 26 Feb 2026 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEjwTS7s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58E61C1F02
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109622; cv=none; b=RSumCy43DQ96H5x04+z9MIisQ3/fVkrVqarpPv5dtxTfDwddIAuS8IEwceb2m5SLWfIqac4iexQScmVaS8hfB0HNV2xMGS3zUylQDolBjKa9dj+CBwHhTMizrkGmCGgWjP02FqBOK6CfrRjiKhsH8NyZJLuRftDig3u2k0KDqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109622; c=relaxed/simple;
	bh=jEr42KT8rQz0J4fP2oyOgD4lF5klf6J0VQ4i4eWJWNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxF6HXjEtV8x16nbIc6iYcq/FqLDFmhA1iarORY31ZNSyu18Xr+6Wqg5cyeNatjJNflClXCYPDchstPVLQKen2mgRBJEczDeutzuUomly3L1bDNiTV9FHfwfNi+zE995OJkufGr6WZORj43B8Es6s5QW7njcq+GZ2JZ9b6imFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEjwTS7s; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6f306faaffso285990a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772109621; x=1772714421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihv8RXYdMK4zG1euH+qM5DQoIBC1ZNF6k3w+q1JGEmA=;
        b=gEjwTS7sJTCKnl+JCzoOLD167TShlN5XZRN3Yb2xkRmU68SXiWyRlTARiatNPL9Jwn
         42td90aXbiOxFg6yUqnHpTUsZvZTjYMebvoE4D6xGzZ1Gxf8W+FZtsTmSpO1EBBmL1+4
         tHHjZQyphppDJ8xMCY4CMVFjKLL8YqLoHQxqmmKoKeiXXFQoAwib3Z8igVoY6OW45LYR
         FakEhYela2UO8olLqQkFn8uOcDK6S9YJqz2MfmBVyrk/Mc3n8/AxsVy+hnGEnSewTzzN
         H7IY/VRW2CNkx+28jjGMN7Xnx791qbDrznRL10wzNCgsmB8n2FDYA0mpDBMpx6HMx3wf
         GJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772109621; x=1772714421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihv8RXYdMK4zG1euH+qM5DQoIBC1ZNF6k3w+q1JGEmA=;
        b=Td5vpeQKvcHX4BK23pFB7zyVGApGguHo11bGaK3mkOjLiDGytzNAOGqchZ68YOpu0U
         pjfAZzDf+MKNNAxzi4QHB9ZXtHboM+VUohSob5RdCLut2Lg4B2QRdLLkq4r5OGFMj4yS
         9nyoCOi/ZFvE+gWjkDu8Bt7QH+yB4oHhYcHSCI8eXZcc5GuDdASu3QKMHNjiDpMKkJZ/
         4udFFiMstamD0G4qNySTyv/yApucNfD25ihvbyHlrRpGEavQE16o53GDcC35Xgazci7O
         btcZfiEruay3u4A0DV8gQnrfA8c60guX5IQHZfYUpBfVHbIuF/iJJcA61py5//NH7pjb
         t+EA==
X-Forwarded-Encrypted: i=1; AJvYcCWN6W8Jx6h4s4RN9Uuh+R9jNPvajy93/Sg0qYcP9EyaMbbsLsrE8yKGuLdQYodvyMuP9C9EquQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmJW5YrMqNesFSuMta9DD6HVL6Mh7SUQeP41SH8BqJ6S1w3gd
	P/ZdIyeoVyhHsLXjQFR+45BBNELwX8LK/nCQw8B70o4xikd2Ajzh2rqOR2loq0qvjvo=
X-Gm-Gg: ATEYQzy4/ode5Dp0Hpw4/8pC35SYhuAzbEnWTW469tbrv48BKvxUIcpgj8xCnHGV3GE
	BC0x9t9++fddp3MPnvTUmo3uG30rA7c1QdyrQ1jxGo6XTVBQJu2j47TBKsNUrgcMp2izyzHDxSA
	51Fq8QxVX94I/jds1SLL1l6xiWHqum/cVBPX89l4XhQQfJOt1eanw7RU3TkG5ySGfMpeREEiZVF
	JZfIO3jNaesDZ8J4IdxWwgMEI7bxcd91P7zGVxIulEjLlywtVApFuSipuyPD2pffGdnr+TJpM9k
	jb7NNSMYcLBdZ5K53Tqri6JhryON/iT0CQpz3lf+dui6nWqOfenmdRIlsWOvq7aPupb8XrYuCHv
	Gmfm7rsMbfcjCDDShVQcB0IUw8W/UnBLHR01a2GTRXcSDizacdXc46EpH9eKoF0uowuELxkBoyO
	1Xw5KV0aSJShR1G0BqZXJJPX8r2ug=
X-Received: by 2002:a17:903:19eb:b0:2ad:99bb:3129 with SMTP id d9443c01a7336-2ade9a9fa34mr42511045ad.50.1772109621038;
        Thu, 26 Feb 2026 04:40:21 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa5asm25476605ad.60.2026.02.26.04.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:40:19 -0800 (PST)
Date: Thu, 26 Feb 2026 12:40:13 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 0/3] bonding: fix 802.3ad churn machine and
 port state issues
Message-ID: <aaA_Lb4cAAmp-w9q@fedora>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
 <aX_6jyAQaDoqsR3G@fedora>
 <39c1b386-e6ee-46fc-a653-f86fa21e9e9e@redhat.com>
 <aZuzn-6vFrcoD9RW@fedora>
 <4f497c2f-d086-46ae-bad7-44285bc34a2a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f497c2f-d086-46ae-bad7-44285bc34a2a@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261331-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B11261A5D0C
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 12:55:48PM +0100, Paolo Abeni wrote:
> On 2/23/26 2:55 AM, Hangbin Liu wrote:
> > I'm not sure what I should do for this patch set. Should I re-post to net-next or net?
> 
> Jakub and me discussed the topic off-list and the current agreement is
> repost for  'net', with fixes tag.

Thanks, I will repost to net.

Regards
Hangbin

