Return-Path: <netdev+bounces-304623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vFbkFfvpR2oHhgAAu9opvQ
	(envelope-from <netdev+bounces-304623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:57:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E765E704716
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:57:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=rh7LLvA2;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304623-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304623-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB2FE30046A5
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3E307AF4;
	Fri,  3 Jul 2026 16:57:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0730676C
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:57:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097840; cv=pass; b=sTYHX2PVh/XxDoT6EPnfVaiSu5svP3WOvDTcg5ell8gclP3TLZf7UMLBav4FDglhZNRzBzV9v5yqARC/PQBZbBP2cBfFaIL1NVblENsbA4vRmZTRBc1hV46m2zeeGb5E8dWiE/hHIS/CcMd+syCuszoQu71FMd+h5/cb3eUk2Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097840; c=relaxed/simple;
	bh=vx6yrIftedLbQYWFX/9co2pg7fVskRhzDGpsvdqv894=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euhoyOiWxQv7bDftD8oF5BXwfkOkpe1+CWS9xyzJB9wNtuwfvciuE5UToQ1qXPhNwaYSIfWP/yfBomeYtCjQ57DD4ut4zWDhuX//qSBb3bbDPhTdwWWTWiC+87zEQOMKMLxh++ns0oJCc3r6J4P4tLpZmD5pH7qc41KZxpwgksk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=rh7LLvA2; arc=pass smtp.client-ip=74.125.224.41
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664cdeab266so1043786d50.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 09:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783097838; cv=none;
        d=google.com; s=arc-20260327;
        b=DdTmFha1391MfB/bSNeFSTUWzz7bdzcv9E6S6DpY6Jgs2uEmJFKrvcvnwNs/4cSpvg
         dW7ZSZeuQHmDSofB0axmMlo3vMcf5aRUF5VSiIswXdZrkqC/QSX03Un89pF9YHHKREb7
         4L95tNPk4K9IpIEkWIIuc8VvjXVDa/HREtwDcMBf5T351OOhX32S/TgLjopJbZBDDrbX
         duAcmrYUic0IbN6AVP0QmAtK0pgWnMvTT/beQ24bbKaavOH6FPfYLc1I0NkSRSoHQX/y
         S8YGevZrYmKnuEXTQeTJfVuZYM4hJgcn8CfqYVzFuMj3fIYPm80aUzLbNIH9h900yaqN
         cjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vx6yrIftedLbQYWFX/9co2pg7fVskRhzDGpsvdqv894=;
        fh=KToyB22D+HmJyeHdAQJymgExWRC6+3lkCyvMxL03KH4=;
        b=H8uGVJ9MTB6wxwJwLOYjKKvIflb7jiRTzm1tw3qbHVoNahdJrxyzOMK+oTYBWXraOu
         KSVsHk0Oft5mkkHSlzYSC6svhDLdEJt0AsqqzGuWvT8vRWiPabpyRGQUt++GYPdnOWoU
         3SY224YP1NJfCiz3gkgMZE6nG8DtnSulYAzj5WU4sqk/NMD0IEKn3gvs/KZngfMEf/oF
         ttLKc05lt6pS9EyhpT5pUAjqC6zTlzuQo7RIGCJqxIPtQLofpztPxyf+rg2sCMbuT5gB
         ssphsXAFzqyAblm73ZoDYTtOdKVTsipjSQw+uyanky9NQ1fYmy6vB1L2NkYaG1uFouGj
         1H6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1783097838; x=1783702638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx6yrIftedLbQYWFX/9co2pg7fVskRhzDGpsvdqv894=;
        b=rh7LLvA22oliSxC4WPJdctztFNc1JEJKEOrsdFJFzKwsnsvBnCCcbvc3np+EEqdYl0
         n95AoZLBIYmdnxdSZj6Yn97/tI60evdGaMkzLrEGR7wu03Xk1coTMcz30BUMgEDXjcNk
         LiO1nYEXmJPch6viZ8/+I+4+bS6+Ld2wsOVfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783097838; x=1783702638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vx6yrIftedLbQYWFX/9co2pg7fVskRhzDGpsvdqv894=;
        b=Ft2zzFW8UD3u9wNChMbOaYT46IZ0xEDUs2QHUbucsCAyqAnDXQSn6h3nUmFLUN7nvw
         KGY064KVDKkGll0KUq9eyldLBWGygrXDWfrsVvP/yCVrYcQGBc9VsYLzlNGOguol5Prd
         fbKY5cfXuRQrSg04t6E7hrp8DC/ykv6640QBSDvNPt5sShY6uLG7W6Zb+YTRIvc7r9O9
         gceOQwpkiSB53HdIWSqMZgGelOyjYk8d9npMsABGACdRCaxVpBLI5qmTd3SwYeeS8Q0F
         gBZqDRDKfgvgerImHglWCln6HR72rgb3gA7gQueudocDpxAxvd7ec3/+fQsVbBYEb1rs
         9v8g==
X-Gm-Message-State: AOJu0YyhHkFUBAHJdZwHooS/9skDN3GO1oCBdNhBZCzFS4+ni5jW9M/u
	aydqWmG3aWl7CCvy3x8wQh4yYtVKLMqAtCEQWpNai0k03t9lBOOzR4Qvh6cH9JuSLhtCoi9ny2i
	1YE3fUwJ7wfuW7/oN7BtZkCn/286N4voh8ME8QjKS
X-Gm-Gg: AfdE7cmKGeWwTXZN4QyE+UxnUZTkCc2P0iPhgNahMmnbLKAGvNgsX+tApmVVD9Z/cvU
	1Yb3vznH29iPlR/yc8nvL0zbbZV6EYpa0wB1MGWXgSftPMWOLzTkMdpBKMvw480ip08A6msJ2T4
	MLPcjBGXFxeQy5/vqwplqlzFI6BFpnmYl3fEJ2amV9XGsRwJW+KZ60jn7DUCAo1jQ/xtzM/hUYd
	ENDQ0pNjMcSIcr/dne3NXGara1i6cdcpBY1b87dwqAxVXxat6k4Ekf/xGWSSz0q9o/3K908DN1l
	wBHxJ8GRN+K2lWCIQhEbyw==
X-Received: by 2002:a05:690e:150d:b0:665:6e1:9ea with SMTP id
 956f58d0204a3-66650c76104mr594117d50.8.1783097837582; Fri, 03 Jul 2026
 09:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630153651.249752-1-victor@mojatatu.com> <e3f99de6-cf19-451f-8175-50fa30012f7f@redhat.com>
In-Reply-To: <e3f99de6-cf19-451f-8175-50fa30012f7f@redhat.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Fri, 3 Jul 2026 13:57:05 -0300
X-Gm-Features: AVVi8CcpmtGS4kPwtxRIPw-uyWSinnHwF5IROirsevjHl9oZ80q_4ZiZHSmoSjY
Message-ID: <CA+NMeC_TrGVJwePRht=xB3qk3YV1tXUTkjW-+WwwwznTmy5=HA@mail.gmail.com>
Subject: Re: [PATCH net] selftests/tc-testing: Add tests that force multiq and
 taprio to enqueue to child's gso_skb
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, hexlabsecurity@proton.me, pctammela@mojatatu.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, jhs@mojatatu.com, 
	jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:hexlabsecurity@proton.me,m:pctammela@mojatatu.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304623-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu.com:from_mime,mojatatu.com:email,mojatatu.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E765E704716

On Fri, Jul 3, 2026 at 1:37=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 6/30/26 5:36 PM, Victor Nogueira wrote:
> > Add test cases to reproduce scenarios fixed recently [1] where
> > multiqueue and taprio forced their children into enqueueing an skb to
> > gso_skb (during peek), but failed to dequeue from gso_skb because they
> > called the child's dequeue callback directly. This causes a desync in t=
he
> > child's qlen/backlog and results in an eventual null-ptr-deref (with a
> > qfq or dualpi2 child).
> >
> > Test cases are the following:
> >
> > - Force multiq to dequeue from its child's gso_skb with qfq leaf (fb6c)
> > - Force multiq to dequeue from its child's gso_skb with dualpi2 leaf (1=
922)
> > - Force taprio to dequeue from its child's gso_skb with qfq leaf (476f)
> > - Force taprio to dequeue from its child's gso_skb with dualpi2 leaf (0=
235)
> >
> > [1] https://lore.kernel.org/netdev/20260625-b4-disp-31bcb279-v1-0-85c40=
b83c529@proton.me/
> >
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>
> Since the fix has been propagated to net-next, this is net-next
> material, right? no need to repost, just ack/nack, thanks!

Sorry, I didn't realise the fix had propagated.
Yes, this should go to net-next then.

cheers,
Victor

