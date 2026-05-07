Return-Path: <netdev+bounces-285236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOV8Fmhs/GmMPwAAu9opvQ
	(envelope-from <netdev+bounces-285236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:41:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD054E6F02
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEDE9300B85D
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8BB3E95A9;
	Thu,  7 May 2026 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvRaz8jG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958323AC0C7
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150384; cv=pass; b=GFPBubHtUXfzxCVc2RZrsnXQwwgqU9CY1TUZZsNCPpFquoEXA77YxXadoV6JMUmDfp3mnKNXqZXdCsvWXxv/15NO1SEeJE7sIe2FXKE8CsAvBU4t5ylSpyaNtteLT4tC8U+ahNyIoOmsVV/txHdqZysnUlBkaqOiQvaODRxZbhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150384; c=relaxed/simple;
	bh=ZMfJFPuWyFb0+Lx1Mzow/kVxkubC9I6DROiuY2zXULo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuVjuSGwRKa9y7//gluYoPqA1daHbai94c0bLXUK/jGDqhzZU1hgHSob/wnrM5pnQu1475b4hhuOELrTb7xFLmIfk61MZrxrMMMGlyfoAIidx0fUBbr/XiCF1RZDxqlC5asbo+sfvc3sVr+yk9CM0DsI4+I2pBxD5W0H6/7r3Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvRaz8jG; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ee62a19730so78795585a.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 03:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778150381; cv=none;
        d=google.com; s=arc-20240605;
        b=FrhrQBFvpL9T62iUrfEexbzv+TDi1Y0o8rkTog/rC/qXYpTPYfJyQnhZBgp6iABEIc
         q0sKl+OE67rdrnX+/Kf9dJ/OZR2sGk4DW1/0FQ0E9fL4MhhcNL3t6xFKSdLlrqwrs0AO
         ga5Wnnbsx8cfknTjLiQds1r1vplu09DC9z0pyHGwp63/OIzGPE/DCxLvEm2kAClz3Igs
         B3Qig+yrpgECHeAWTAmnfh8lOAmQAoeLm7q5yxXxglL0SmfuU3y5+xuVN1ZawgYM2FX8
         wF0JLJXBI6SibZ0LlLaWB+fTtz1yOlI7QlHlkM+RS4ZvLtfDj0iAzuZaMMcRKfofyNu8
         68+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AjG3bXQAdsvKFxIsmIeMUK6Tdm3O2yjG9Bn1nPG6HSg=;
        fh=5C2woG64U508Htc0luwbRxxhATyiu3f94AXBAQocSz4=;
        b=Ewjgc7sw/d1ZuHKf6xXHm7rlcpxg5deHywDgpfw2+xQdpiKl385bDsvoH5afbRzjb4
         iurrhEGlodfCZRYmHV4ELlgYVOENc0tUTWoRokFqguiV67sXAuXjluI235ufc2759wuK
         T+6cKmO8Uizr30stG3UDBri4cyQSl/zv9INKz7OYKTmUmudKmzv6z9/AqOv1zBmHZISx
         53YSK8NZy7/LBCZZ3n037+pT1l+vHfXUz0KxntBUuKmR+41Koa6utg8fpUF2JNw/8oSO
         zEcKeCgHOJwNxY32avRGtTCD2k8i1MYhtaG7wipDQoxFlmGzSLpaeSDZhNuU5YRrcE+y
         lP3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778150381; x=1778755181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjG3bXQAdsvKFxIsmIeMUK6Tdm3O2yjG9Bn1nPG6HSg=;
        b=FvRaz8jG6vfNw28sj4Sjc+vWHyvTY4zOETCK0scLWFWSnabk3TrnJHY5r0Swsx+2ez
         /73fqEzYvDitDCf/GjA4OGE9jAKx3Bmx1TD4w8nCMW0U/1rQxpr2QzHZq2NS1W15zb6r
         XvorC4RjXXgks8ybsIG6H8pMFFM1hB8yHwg0b/RXF6+j5594J5/HgOMAGDctP/cN4rZo
         8H/YpodsdMEHSlYiXoEBPFUuD76i8QdmCcXa4R19O2IXDqzraKfLvr6EkAH2rJgZwhSU
         uwPdSbqmkxFcsnY4dhc0QvVXrq6atnIHUJRLE673wyQLQ8kN7tgYCMMAvxSisghKAKfX
         ID4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778150381; x=1778755181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AjG3bXQAdsvKFxIsmIeMUK6Tdm3O2yjG9Bn1nPG6HSg=;
        b=amtpdHLdZvObuL6qfVQZq9MYmEd/zcayL+zbmM53o3pVw5U7TqZcCJuxMESZQRz+no
         WVIlT0aackElRaIxGWuw6boaLi5l6DmywqeXb9kkaUYnYbfjXHG0uAI4vx44QZp31TPT
         Pu+jtlufdNwK8h+JuRPCItOfFuUEqo4ucPWWT9IDu8RSirN4JO24KynPJUxZsjtp/10f
         GMc7W98VEZPa+AUatgZc/PbQIcXlgj+l0Dop3lzx2Xjd7vUa3buo+VhbFfJWKEBG1odj
         Sx+Exd501tGM/UYlwJRhUOim1Uwztp3Bcmn3QXDqTT+R1z0XDV/4uicEkLWL4dryA+oT
         p37g==
X-Gm-Message-State: AOJu0Yz38CIoDGD7/JHfd3Rhr3uEHDIqg2lkgRQW1A0JWtJ8ks15G0pP
	drxo1CBKRq4ixgMeLKWOMp2BOMyam3JMjqp3OgSHBEMTWNw7SO/ucJRidP7RdP9o2PhNSiq+jfV
	1kSm86J50CA1z4fRUo5bNpGdDNthi9mGpxLp2n3GU
X-Gm-Gg: AeBDieuNFLK85FBBgYIVvfDcD43PMbzs86LSkscqwOfl/nE79nfOU8SOuJ6zSP/a4ig
	8r+JOqptnoMBbk8ZWxfd1UXCB9Z9gW06CxfrHiUiSpkh6Rt7kaF4LgpFZpMv+wQFsXrPrQX7veW
	L4I4zef8KoiLK4mPbOdaOL3PRcN7bSCBwlwVlJVY3jRTFQXEdYeLG/bqmpaS/ZF1DrasqLAb950
	Nb+AlQNk/Wgxrl2mvcSx4Kx8W+uKPNu4kK5/ZER0AZqm2iskKRqpQvtTtg6qsCiKqDdsoyMo0OW
	8MuC6gIXP2oPCmD+q1ykB467mgDgs9wGHSC3/s1UD09YQghENsWwztf9b9OYJPatZZXHMTrh4y4
	sA4/CSzucrn5+aQuM4Y03NSxXwcMWJlsLOSEU8VdnZ51MyZaeY34E
X-Received: by 2002:a05:6214:2f0a:b0:8bd:de6d:c332 with SMTP id
 6a1803df08f44-8bdde6dc70amr28935756d6.19.1778150380407; Thu, 07 May 2026
 03:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507102005.263436-1-agarwal.vineet2006@gmail.com>
In-Reply-To: <20260507102005.263436-1-agarwal.vineet2006@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 May 2026 03:39:28 -0700
X-Gm-Features: AVHnY4JyYrqBxDglFzHHqRgaWpeujBGksdO7kID2oUaRDEnDjLST7cvnpE1W2ME
Message-ID: <CANn89iKQoYE8swpwbhLhJGT8WKL1xhEY7rCQKtuH2uetUrLQHA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: sch_dualpi2: annotate lockless accesses in dualpi2_dump_stats()
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CAD054E6F02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285236-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 3:20=E2=80=AFAM Vineet Agarwal
<agarwal.vineet2006@gmail.com> wrote:
>
> dualpi2_dump_stats() is called without holding qdisc lock.
>
> Several statistics fields are concurrently updated from enqueue and
> dequeue paths while being read locklessly from dualpi2_dump_stats().
>
> Annotate these accesses with READ_ONCE().
>
> Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
> ---

Thanks for the patch. This was on my plate.

1) This is probably targeting net tree. You must select either net or net-n=
ext.

2) We need a Fixes: tag.

3) WRITE_ONCE() annotations are missing from your patch.

4) Please wait ~24 hours before sending a V2

More details in:  Documentation/process/maintainer-netdev.rst

pw-bot: cr

