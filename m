Return-Path: <netdev+bounces-307091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NuknM86mVGplowMAu9opvQ
	(envelope-from <netdev+bounces-307091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:50:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D9B748EF9
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:50:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VA4SZZxk;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307091-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307091-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EA1130316DA
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57763D3D12;
	Mon, 13 Jul 2026 08:49:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F533D3338
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:49:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932554; cv=pass; b=UYH3yIIxvXgdnU1jrLwIK7l6Hxadg3U/P55aOtvBY0OxSUO3hDFN9otsECYAcK0ozw9iyjfHrZXdiVmSYiws6eAXpXeZdaaXd9nQDbxsxqoCa+/i5OaDtL/58swgl+7G0wROhxi+ZM7L/oamQVogDUCN5J4m6FGh29nAdN1QEzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932554; c=relaxed/simple;
	bh=OI9kyY/eIXiwDJQlkP1NTCz1k8ZUsmR6Qz7FiRC7tgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otuQMhVXIgn2LZxOgt70WJdU1HZ/mvQkV4+zF6BC+jMVdvcO+rt0KEysnMh0L8eYvTl3R6p5jvKi4jCOS+ubHAaqLAvRzJudU2Va+vzdPEPJfRIcQ8+BnNUB/XQJU1SAf7xYi9FSiwUsQZZPJCe+KYAIAgkEqV/+EOKxAD6mkNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VA4SZZxk; arc=pass smtp.client-ip=209.85.222.169
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92f0b5ed131so37769285a.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783932550; cv=none;
        d=google.com; s=arc-20260327;
        b=k3TLCkW3tWuoyjExCg2aNve6IDsqv66+4rW62Eipp6d+TYJNN/opE0GYX9oLF1TwsE
         zn4m+mGojjupz7zpPwMc7KsxOq8OxUH9+48wp1vBcakNiFE6vfB+AhGI86FnjQywVVsx
         s0lQTgy83I58F8WwAPWp3qj5FUVioOkzfXhYA6tE9RR9spLJ86PisSJknySCDwOClUYf
         BZ2WoLD3Cnu1RJ8G3BIaIRj+9Q+pf9BwvhOlIuGSqKIWBJiiqQEETABjryv4bKu0kC3B
         9GDF0X+hxI4+984Ltj4ZR8XvKwYRV5rPAba1wiH6jQUEztgZMWzTYThkT7qKAfCUoC+D
         UkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QeXRhEeLsJ9M/v/PCGpg6ym+QyLMSFbz+fam7a09/Y=;
        fh=v8UFJSeLPJt29zVL7fP/E9t0f4liOBi+1Pd+31yALhA=;
        b=MRpTwCndjw2eOzRw0H+kZrK1nZUu1pS/aOZ8tcU+rCSSY0S5BkxwtyOISs7yUcamgK
         hAZhXtT9MVNXZUS5m5VD0dfkhNbUBfe6yp+O4rKq962IgfblQ+mvmtsw1IPhFODJo/3e
         IfnsrmZppZd1/GZxauPCtBWlkiW4ZPOn5fsu9BbyTLQCemMH8EaU6DMkshmILyUdeX8i
         wKknivHswEbUN+xjzLlwOCLEbox7UJqwuJKfdM0nP7YghR5BSr46upApMvCdLpQPAzMO
         VmVcUIAgRcqUnB3ckoJr5GfdxdSMCWxvQesVsLeht85yLmWTPxDf7wPjaRDjOxlIrmHl
         jmPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783932550; x=1784537350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QeXRhEeLsJ9M/v/PCGpg6ym+QyLMSFbz+fam7a09/Y=;
        b=VA4SZZxk68B31TJJyObJvL1CLRv0yrADyCT+wZYvYP3J21FtjAg/1ggyjIYf9YJzY+
         YdDA1kMzBRwTBIvNyauUHP9433qfTnjQrCZc6SZHuuzXJ6cIOV+1PgpWeZKQdq/itCkX
         TUFias1/p8r/eXMJzfz3PN0M1S7XE8ieh2ZFCEMxnbDbpf5b4diVDfi8g/bqs5bMHIWI
         AJigiB+G+35TIRgNppxs7AzX+iHjMlEMG57vHhhCXIbPvL1IaaHSxObtc0vrmTFx12a/
         4WFYkeWjrl5Agh2yT/27E0VlldCZY0d6BHMcoHMbIX217v+bou6PqpTd+bN2mkFOoE+C
         lgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783932550; x=1784537350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QeXRhEeLsJ9M/v/PCGpg6ym+QyLMSFbz+fam7a09/Y=;
        b=idwEBWbMwG73W0dolfczn5Z+T4Sisk8iQdET0KM29HXmtseYrIxWeNTfARaKt9Mzmn
         rHkm22/w/nBIGmWgZeB5/BdXHjHEDyKZv3yNaQR8DjW9IEWlEFZisQyivigzW6uvmJSb
         bwd0wuLfkZkTNfpGBEbn7aH1dQ1+EsyncMT/KATeekG507FjYqqT79gPrj1diQ1123gs
         UYikXs5x4IQEvXG8Xls4Ss6x9NYSICds/li7HkxE3dloxoer6rnm/52WxrZbY43eg1LH
         cf9hO8YLu99IegcVuh3YwBKMouRaqOvW7CRq9zcyur2zlOTrvrj3H9rC8K+zPVdWt547
         jRqQ==
X-Gm-Message-State: AOJu0Yx5XbLkvbM9qX4XFDy1P2+ddPmdNiJULk9tcjmePTkskAckBfPD
	CSRCVvCYwRdGMfDVTmznv6Uxx7IDqsHbibxGPVX59RYTuPlbkl3SVmL62W84e0bhb5g0LewEh9a
	VfrxTBT3yIu2kq5AIOROWUv/x9sy/PU+U6w6ZL//h
X-Gm-Gg: AfdE7ckHPzsSW+15ruB92YYFYSon41W9CuadxMq1Hw2x7cu43UjK5DhqwWt8it6ICdY
	V0wYiwlODM8vFKxG4MeUsSiWhxFmR6kdZbC4uu+7o3nsyNzsAI8cnpd1cMFzdRKkjwqeMekJvE4
	s7zuvJwhlrDiOE1AFTtyQNUTcy0PQ0kzU6PCjwEGAamL2A3WHFiYprmFLDCrW48EfD5vz3WU4G7
	sMoE3Wxk5tbdJy0jLrSTSuRZL8sYFbkMjTeIfZNmKyHLLYTyy+q7cv6lYGnj8oUtR5NFS/tgeoJ
	rj7VotITvrOBEEhM/Feswfirs3KGWCubFfy5OJTWktQ/98uomq/5rp0Kmg3Ox/Y3K3pEo9Jkw41
	PqsqeUDYG/No=
X-Received: by 2002:a05:620a:4056:b0:92e:cc01:a67e with SMTP id
 af79cd13be357-92ef2ccac2emr869849485a.76.1783932549214; Mon, 13 Jul 2026
 01:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713081842.3119-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260713081842.3119-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Jul 2026 10:48:55 +0200
X-Gm-Features: AVVi8CcxvHiV3rBj-_RY-o3IkJxjxcn2RPOT44y0K8E6bAHhf_6ECXqv5C1bz7g
Message-ID: <CANn89i+jA5kPcZrjXfsY1ic_LjeEwPHi-U54kYmZdkBKHB+vTA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: initialize standalone IPv4 ACK options
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[mail.gmail.com:server fail,tor.lore.kernel.org:server fail,vger.kernel.org:server fail,tsinghua.edu.cn:server fail];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11D9B748EF9

On Mon, Jul 13, 2026 at 10:18=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> tcp_v4_send_ack() constructs standalone IPv4 TCP ACK replies on the stack
> for SYN-RECV and TIME-WAIT paths.  It currently zeroes only the TCP
> header, not the accompanying option buffer.
>
> TCP-AO options may have actual lengths that are not 4-byte aligned, while
> the transmitted TCP header length is correctly rounded up to a 4-byte
> boundary.  tcp_ao_hash_hdr() writes only the MAC bytes, leaving the
> TCP-AO option alignment padding in rep.opt uninitialized.  With stack
> auto-initialization disabled, those padding bytes can be copied into the
> network packet and sent to the peer.
>
> Zero the whole reply structure before writing options, so the alignment
> padding bytes are initialized.

Please fix TCP-AO instead of slowing down TCP (almost no TCP flow is using =
AO)

