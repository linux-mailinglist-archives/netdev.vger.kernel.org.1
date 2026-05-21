Return-Path: <netdev+bounces-290427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKciEikKD2oHEgYAu9opvQ
	(envelope-from <netdev+bounces-290427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:35:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E27E45A5FD6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37FAF30A8901
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D45B3E1D01;
	Thu, 21 May 2026 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIIacNix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449C3E1D0B
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369246; cv=pass; b=fxlU2pkO94IQBt51UcoS1kYoutArCVKHqOmOp0xAFU5y+jZX1WDRD1J5HotMteCPxWCuI30UeKMe4YH4qIvXScTGn5cLmbOycKFt1y/OYMqw/xBdTmeXfZAUj8kjK/uk7JIFbNTcJAf52lL1/FSdDf5aijqyZ5yCClPNtzwJykA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369246; c=relaxed/simple;
	bh=k5Cj6gMrsb1O3lLqLNbw4scATAJUsFVLbJ6mgkv21A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6vmGwWkhSwmU3bZ+DeVm9XuBL2nFOyuvdH+vhDYfcBZ3PC+KaxnbPGzoLSPQOAVw7FVnY8i40b4sP9VL052h8757ix1rh/+WG2eSR12cLTyV/IYpwrkKzRMsRPR9cZZ3B1g4gCbx1MpF0hMm4YlsOTmXvjYiW4zRPowpm40RDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIIacNix; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39397d63804so8855151fa.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779369244; cv=none;
        d=google.com; s=arc-20240605;
        b=F5w0wlUbagG9yXkSiEGlCR6acDkJFDhycq3CQWRkmoS0sywhaliu/C/R4IHGvu8V03
         mcVUxoSgHAFT27i2H0WqqqIYvtmDXcO8/5pLbS+efGM2CLH2WV6H4vV0phjxYcMHJ1ed
         blW+ute3eZrcAik3/ePUm6YdvxPhZG5sfkruO/u/a88+v1fy4fxavJ2IJyIB2ThLk8O/
         euFTlLzrMc18sLgNx32C/GHa88pefY2iXTO8cYhadEAotKUcPw4MMqqeDgnfbyb1SRUI
         U0ELivoGWVGIy8jqdbzzR2cd2WedOMHm94qxQqImlJFirLQAjKQHntn6MJdtCHAUPTy+
         +64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k5Cj6gMrsb1O3lLqLNbw4scATAJUsFVLbJ6mgkv21A8=;
        fh=vH1Jy10V4i2W/zUBD/mFk6Hd+fHOZin2S3GrAlCEnMs=;
        b=eD46mafPjf+g5OUkT3jHb+0a141xk3cg9kfdNzoZVskroT7QwgQsXO27xzheeiIXxo
         BruvhkSJqpKg0iz+JCyudTAXbJZLgmEio44Xx25JnSMoPJZvFsL58xuf4RCA9FPco3Y8
         46dbdkynzLUXQxS8P5HToEioHtaqT//jFdD0c1Ix8phsIreSQtff5TemdUk/Iti66t+d
         sKzbpWVQg5H9fdi/FWarEJObuJD3KZ5fc2oVLpeHDGnqkjK+/FUrf1vMk4ZN6RZtrfuN
         vYPXkpHwEMqMXjJAMj+s0jXdpRWPt+PcTbOhz6qQeBSXlV35jhQNKX3DOZkwlpvZlusF
         Q9Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779369244; x=1779974044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5Cj6gMrsb1O3lLqLNbw4scATAJUsFVLbJ6mgkv21A8=;
        b=VIIacNix6duNeD9tvnGPE+IKPy3tSDgsNxj4H1eHU5C/1QffjIXA0Mc8on5ILYk2jo
         /JWcF4dT1zGyfz2lIS0WvUH6/bI9NC6Rdc1qpBPf5ukQWI2sUQaWrVCswvArzYrCPOAT
         QVsEBfgjMlx5B52RPPRcqYv+UIJdR9lgUHkDtDia/tLQMWE3uqLRljpVhNkkjL8q/VFR
         2l/UQDQFbAc9SoP6C2JuVW/DZiAx9BbnxkiYnYZYIg6Is9rlquXfCgk7oKym1wfnh4Q7
         JqqJ2XmG4l7eRa0hlLt/C/ppJsaX2ZAJO2JRg7gJIi6thTXnRlypu/efYCFjfCM1EnBu
         XD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369244; x=1779974044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k5Cj6gMrsb1O3lLqLNbw4scATAJUsFVLbJ6mgkv21A8=;
        b=LoVFg5I25dPVPNWkzf63s6zDcRECXWL4PoJKzOdPEm6laNL6xgKiVYUZktmhBnhkgq
         IFsHFhv86uC1sB54JObyzx1tcoEY8i6Lr3GXy2KP2Oc/sZN966skW2kUcDPajgi7C8FU
         9+FIikjhrfIu/QI6EnxCjGV+/HkWo1/dUysnU2KpYXC+/XHgP2vgfRnna1yLsd3pM87q
         QTG6IAqEzqsIcqryViEXYErTyX1sgRGZG/O6QXYFtYBOr0pxXucQfSsfDtIz3g+Q5BpR
         r9NmfIy1g3wJTa8rwiSBUTH04Ul9E7lNrp9ejFQkSE8tm4zDAKtPfLOPMrhHYmq79hQV
         LgGA==
X-Forwarded-Encrypted: i=1; AFNElJ8lHKwLGfZrE0bjW5rQ7SO/KoWkk0nRMR7AeOg1PK0aJtQ6kuklvWrdbs9t9ZV5aj0zG2UYhFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2MUYToN9hi66ma6t3o0LtqWfIM/T0lIMHalrHvLxO4qa99n7e
	9d5vPwiiHZ/sjflx4cPjPiCsA/VoMZDDrMb4UZCDtABN+J3fSuQPGxkGCELP06oXP1ybO2fGWec
	VYf7jIpvif0z2zzoLlvAnOyFapsDNXXc=
X-Gm-Gg: Acq92OFXXVpEmhDFUhTMQuRAsvOHZ7mUvRaFJ7hExd6UohGpcCIAVzDZ5UqESTOg7D+
	HeKt63bZbot4jkST/mXj7ELyXYsnVLVf+LFVlUT/VR5auTrb0e3PuKm8PSbirJzyj/CAGXBpkCr
	8jeAn+M1hW8zQmoYdlb6EUgdVjHwk669haOX4MQ7GWAr7RktqM48bZY/zD7Xi9EQevNsvrOTdqn
	e7a5grIsiZk0QPXV0dIaNWOD6pNauAd7rPBq03AK+c9TMQ/qLZAP68NpZXKBP8osfOdBvMjHT4G
	Z/zX0sjI/J95CTrZWQoNgPcx0m+HqzvGOS/dXdUKIHy4M/jPAw==
X-Received: by 2002:a05:6512:1443:20b0:5a8:97d7:8c2e with SMTP id
 2adb3069b0e04-5aa2ba939d5mr888320e87.28.1779369243628; Thu, 21 May 2026
 06:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521122147.3584624-1-edumazet@google.com>
In-Reply-To: <20260521122147.3584624-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 May 2026 21:13:26 +0800
X-Gm-Features: AVHnY4IPezvqoE1cO8mu8k6Q1g5c2UGSpBCo_6-6pZG9f3hmnFUCZFuSdQfuj18
Message-ID: <CAL+tcoBkaqP3gBE70KC3zP2hAXCDOeibSQKFvR0SQVMo3DA0Qw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: free net->ipv4.sysctl_local_reserved_ports
 after unregister_net_sysctl_table()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	"Ji'an Zhou" <eilaimemedsnaimel@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290427-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,nvidia.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E27E45A5FD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 8:30=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> ipv4_sysctl_exit_net() is currently freeing net->ipv4.sysctl_local_reserv=
ed_ports
> too soon.
>
> Only after unregister_net_sysctl_table() we can be sure no threads can po=
ssibly
> use the sysctls, including /proc/sys/net/ipv4/ip_local_reserved_ports.
>
> Fixes: 122ff243f5f1 ("ipv4: make ip_local_reserved_ports per netns")
> Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

