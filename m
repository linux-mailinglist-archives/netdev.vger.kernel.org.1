Return-Path: <netdev+bounces-251456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMZDCwhbcWnLGAAAu9opvQ
	(envelope-from <netdev+bounces-251456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:02:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A625F356
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DC7B6C91DA
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7CB276058;
	Tue, 20 Jan 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9c11kkz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2173876CB
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907873; cv=pass; b=eCMjN/FAB6JRn+sD6rU4gz4gmM5YUWdX0Vvt+8YLifx8eQnK/amhacvnL7gUj9G5fnf5lVdvV5JEaH6f4HVDSjm6FRyWEDhAtZCRi1Tv+Vr2tfxgZsbNn9/Jf7/qmBxBrda93VifnCsPdeucSzJzC2tJ566d4Lkik9WlAZbTRuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907873; c=relaxed/simple;
	bh=+sWQu3mnwAYe5cAm+JptM014Ieze0cFQaDL3tDW0IGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTSWV93EaXQ3dGnGLD7Az3AwKCGMrgwTeTUjG7QVf/Xzql1YoFulMkC8z7Gp2WcfjSDxKANYOX+o0Zv9iLC2cC8pJYVFWL/pBXp7TGg0OPLGVN8e1ZoMluCzJiHx8LZCj0/+3p0NxpWaU1rlBkHaXTXOnKc4txOwy03boGz9kjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9c11kkz; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-404254ffe8aso3819935fac.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 03:17:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768907870; cv=none;
        d=google.com; s=arc-20240605;
        b=YMNL7Yf2y1m22WMhUcXfZ62GKkoaHRn7xvNwCn671b/ItyOiYUmy+EduFdtkZJk7Mj
         racjFUwN2cz4AOZB3SfWR+vXbcAIHEfanCtF6Ma/2QpX5nvBoL0C7eH9hNStGYXjcV2M
         rNOv4FlEOB8fcSN21nfHLP1U+0XU8uBnIuEXLRT8cLYk++PPBHFMTGw4+B0urRHB8vrl
         LM9pM6cPZAxvjluWB8Qp/mQkbapkdgXIemU+gKjET5BbSvo0nqeFZyOY/hwOyx31jDsG
         oCkY/TRaC/8KYGFzeksq5PZHxpYuNTnPJmjRvGihXWiC01a9WfiPlIjgh2g+GR/ame2p
         J3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/SP9NSk3j84MyoZuz29fwD3n6pbjbov+PIU8RueR8vU=;
        fh=0LXX4d0oAItX1XJ3sGtH1VihYlVsdigM/HeqbcrGqm0=;
        b=lAh7eAPsz5HFn8XNcpF9iFqFcdaoU/OIBwVChHYi6XeSm+ZB5yxhKAhOfH41dpIzQj
         bE3vtlNFXyCh2AUkZWXzBF/amg1Yl6b1g/NZuhY2T58GC8mgxO9aR4UV3s+1XHKIm/FG
         NgArJTqOmaQZ5GvuUZO8Vry6LLngI/d/4fZ+/QZa1msZXdRhtSTPOE2c79TCBahp/PcX
         biLYdGWgAgLz9zTR6+bzp+Qj4Ain4T7cYEhX44P0Gu2G9FR/ucVYEWFaTLcmlDy0zHNk
         U2NWl9LO+XKsqroqvdIvscBR2JLZSb3fnQFsmSTCztG3sUYrrfk7jVMjfz0aHvXfgXno
         URMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768907870; x=1769512670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SP9NSk3j84MyoZuz29fwD3n6pbjbov+PIU8RueR8vU=;
        b=S9c11kkz4V384HtZ6EcFC9+ErSP//gfv44bNzTxVV2SZ5BRl03PO/a61YaDqH82qYp
         3rgrpiHEqaj6xCv8Q4/ZAIpwAdvJwYtivq9DCPprtxMmEhWPHR73u6xI6WKUzyJx431O
         zLIU962qCaj1yeqwbyGQovOwnaTGiEssja6cU/Px+FVCdQ7d+En6BRB3+Z38w/E1WL39
         ftR9rHAm5Xnw9jxb2xXARYvuubl9EotDGXU+XvGbfJxnRCWZJY/nqBeEQxdNihvuwnPd
         wiwMEMQdyJKbFzxsQ9LTiaP06N/i1aowCMZa5hdjCUbTO9pksQDryd6S7mwnhxJjrP7a
         i+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907870; x=1769512670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SP9NSk3j84MyoZuz29fwD3n6pbjbov+PIU8RueR8vU=;
        b=gQQTrh9/72SAk8waOFA+aAKKF9PQX3a7JjMs8K0Txj7xNkv2amjG6zRiBOTxBQ5O4f
         TpuQNKh0tQnlABB+vPSf08IvYFdRfd+OwaY8IJxtunZO5U9bSTARcMGbEQBzYCQDYS/M
         WYf9eQhQ2R7JbPmpaOo+/t+7MJKhNtzvKLtgKBENy23VVwtteeLnTd90ukxtI3nK1Lqg
         teFoXIWMpj63eFOjsC6y1BIvkI3nDAscfiYYkag0KzvdniCTG9mfDTnZPT12+Ut81amf
         kbFjPEBbmq6clVXcxx2JF0c5xlRtPL6OQdR91Laz0hiucQny1xBVfJaD2Ih9ljPhMR3s
         W4CA==
X-Forwarded-Encrypted: i=1; AJvYcCUAkpdsmmSkkwOsR/lXLQ6nTHQW7QnlyQrCA79TxkfTSLZyEnkz8NeDG669sUh/AnW2RhdgtrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqp0TdsgIEW3k9n4gIeQI/j/A+k1EQ2Xn2ItrUKkGb/qv9IXPF
	UJ9Bl1iMK5x622u2PI9rD+B78PzO0R96Xg7IVkdrCtvP2UOaOYdxydyY+oJwq8MxXiskeL1eUsw
	KERkjZJUlz6nzUCCFjnW1BQ15wordisZtMz9l4ues
X-Gm-Gg: AZuq6aKGcmuPbs2gamjkBI6q0g//900vmkrPSKapupL4Ix6zfZWBtWzyoioQ/ml8n8K
	KIlT3j5zPy4fOp7ilsnMyLqErO8YvjMrljjVnvy7iKcxrfmkpLVAM32Vh9A9eEinYQPJ11hD+XD
	9xDjwmPOdT6Ku1B9P/FpaCet2S+rGNAz/HSwnMpJZwG0th8JRnGjBC6dpMmfrZFBxFZLMs8lSxS
	K5GWc1oSwB4WpXa3AaQeqcgy7xfonO9UDugQmayFyZFm7Mbr/FcB8XNz710OUbzh1GIEKlmF5df
	0j4ZtXlcr1xF5qcxPYV42yoZ+cybSlnllgNxCQacRC1W1k3zGVRlreeGaA==
X-Received: by 2002:a05:6870:828c:b0:3e8:92f2:caa2 with SMTP id
 586e51a60fabf-4044ba1ed44mr6662736fac.5.1768907870040; Tue, 20 Jan 2026
 03:17:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <696de90d.a70a0220.34546f.0436.GAE@google.com> <20260119084647.34505b70@kernel.org>
In-Reply-To: <20260119084647.34505b70@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 20 Jan 2026 12:17:38 +0100
X-Gm-Features: AZwV_Qg3My9SKiL7zOxnwMqLAoC-FlFxAF4PzC20393hIb55FGzlVHcwzmD2XkM
Message-ID: <CANp29Y5nuRQVrR6fZBapxN1cnzvnzm-C4a6FVUpgs46WYvVcug@mail.gmail.com>
Subject: Re: [syzbot] Monthly net report (Jan 2026)
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+list849c3c7cc70ceeb09a59@syzkaller.appspotmail.com>, 
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[35];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-251456-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nogikh@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,list849c3c7cc70ceeb09a59];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,googlegroups.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 87A625F356
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 5:46=E2=80=AFPM 'Jakub Kicinski' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Mon, 19 Jan 2026 00:19:25 -0800 syzbot wrote:
> > Ref  Crashes Repro Title
> > <1>  22186   Yes   KASAN: slab-use-after-free Read in __ethtool_get_lin=
k_ksettings
> >                    https://syzkaller.appspot.com/bug?extid=3D5fe14f2ff4=
ccbace9a26
>
> Thanks for the report! Could you reclassify this one? It's in RDMA.
>

Sure, thanks for the feedback!

#syz set <1> subsystems: rdma

