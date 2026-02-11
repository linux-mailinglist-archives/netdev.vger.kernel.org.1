Return-Path: <netdev+bounces-258302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBnwMg+ijGlhrwAAu9opvQ
	(envelope-from <netdev+bounces-258302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:36:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD1D125BAB
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39B103010493
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C960307AF2;
	Wed, 11 Feb 2026 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ii+AsDIw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5B30748B
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824203; cv=pass; b=f7SoQUswBdlb1tJj2BYxYcPLZtQoIF+iR4pxoHAFFmPlGIPVeAY7eYXw+GPOd000WoKfyyubx2tKLk6GPLSzVT9mGOYA9yHrFO5Rahu2Tpd0IB6jb5gpLvmBjq8yy9HtpZL191KYVcO/u/pOnnc6bHzEMdGikreD0go4ou9g+EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824203; c=relaxed/simple;
	bh=jqd7Pci6pO9FGBoMvZVYHreBQHzYczgY7hgUC5HHs0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q121pphc5KtBbTP/Olfl8o/cK5u45NmqnTMgzkPJGgm+U2Oci79dM1iCq2EJYSpV3B8kLPBTT5jNxYlA2G5BjV7nhwE/i5W0keodN1EjCfrWDfNv+/AXu6MnDc0ixGTrYXYDGaOhwjLywVVhN97SD7ipTocnROQTfXh3fCAZ8l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ii+AsDIw; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-503347dea84so64079191cf.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 07:36:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770824201; cv=none;
        d=google.com; s=arc-20240605;
        b=hfYSUgTJCUQIzxc64lAoIY+svlZR/hkHDMsYKPqqbthVpp1/aObnZeBwEJ1D4LSkyK
         N1Hls9Uswk2WSIUaC/X/qP5V5t7z8w9uecIgoRL6QMj6cFgtJH7CNFNEsB5X/O6vgD1L
         Xnvv4UTqlLyapfa8f/4wUwpSCp6JP3Tk0jOHGeLp3U/poMy6rwXhwKfgrj3u80KN1Z2S
         UJSqWOyh02xIUzTv2qpiy55CtBKagSmPBWTi4mHXVCYo1bA29WAHFY9UzHiLRpfU37tV
         LfhqdTGKn7+X/e+5V/XmWGpUkZgLTqxImynfZ1lTbFIbzDcREwTC2bCsRyDMGW2jaZp0
         ewdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JSkphXcA5Qjfyf1LyEdX5F27uHMSV1cYDt3Oc6QFKQc=;
        fh=zV0Jg3B8CmmfWnX6pPgw25CVfJeILcV3hn379Z5sPYc=;
        b=k/buU+1mwvWjTEwNEstIWM3ODVOGCdKuR0KkUho1FSy3brJMkH6n8+mzyiGxz9eQju
         o8OgNZLOE19dGAV4fUDnFYfUlF6PTqcl9w24DhttXWg4TtqA4BQQNGEDM+oK/YMsMHQO
         UrQKSMWPoUsWkAGvzKe10Fuv7feD4gW/6++QYPkTgRZaXIgPMsVQgiEzxnlz2iX80CCt
         KCVDQ2PYhiW2hDJOYW1JlkWYFQ7EX4cHqM9CThHQawRAKlC7ykmi+23vQt9y1JopXyRs
         j4BwCbQ/YtxCfu9sDlIxJzGPA3YHPvK9u+VMJ9KHtRa14VBRVyWtcFbeO3pdt/8GJlZS
         xecg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770824201; x=1771429001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSkphXcA5Qjfyf1LyEdX5F27uHMSV1cYDt3Oc6QFKQc=;
        b=Ii+AsDIwiS+MbB7Day6D/X5LGuXanZ3cnuspUDHPYWqUpkd4qvsmgs4xk77kNoVAZP
         VvF3nCcGy0b5ePgKsh8RYNAk6fGea1qaVRvTpmwd3mrEwG9s3a0obTl2he8qvEOVFoxx
         S5APmq1TCNWZgUykV9RaBGYIIlAs956U68NOsuzArsDojqkxjzlNVvj/P0QStEZ5nIiP
         LwbQNyRKs63Wkno/Z5XCJYDXUkVWMHZy5CbNF4NJ5c/sufhXmIIGJnPu45pg0kOQgO6W
         2KmKi501Lxts9RowmYEK8Ab/cOBs59NV3C9L2nwf8uZnMPEk3OUHfIT0YpOX/okNjfH6
         OnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770824201; x=1771429001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JSkphXcA5Qjfyf1LyEdX5F27uHMSV1cYDt3Oc6QFKQc=;
        b=vbemHbcxP56jFkQU9cy3T3RVOXAA4Lu44woO/Dy+2ABTAkPDEV4FZurJLKwP+CCYm4
         BsX90jTViTWqMj0JwIfw9AK+GeCqij4wSTVua4wjgQExmzpB9GzcZyOAgolJX7iwoBUo
         ivjZTsEiU57x7HgYZFTqO7bj+vE5g41Kgmc0sxjOfLqRgMCDPtf8eyrjM+Drn183Bfz1
         t62yliPKJerLkwKsQqMfxBv1gs56q4FbhCAnP392y6+dB1jnZWl7lHGbtBRoZHgHasQD
         MiK3Va3b4nrpO1c/SWN2tSqEJTEAEhq9Lp+Q1Vk+fdUTVw+F2iIRbMraCOOyL0HTK13t
         xC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdHdAKjXW6JvIaRfw5g947lBBzR/6XNSthONDZ8Uyac7fvFECrk5D+xgDZLVq+TtmY6W5v8gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCKfKkeK81GAEzSnH1Xfyq4eERWBs5cg8h0EL4GJTN8nyLKqeA
	X9RFiULHyeWkTGM2gHnv+qvKn/LSlMEByRTIg9GvDirkdNdT5utlrsD8l4rapRyVvHfzngqZMtF
	0kZz1nsy5oNEM4m0BBeminYbnBddpkP/Qv2bS/S7U
X-Gm-Gg: AZuq6aI82L/r+AS5qqaM3AC3jp626Fnv3LqrlJBF2TfCV2rOuDOhl64QGlm5SIvrxd8
	KkTfFjrH7rPqyxSgaDxXBs2aQl1FsQer2PwRp3ODbAzQcQcYT8R1tGLm350xcJsPhxd9tGHPz+3
	bEGJwWRSbE6zn6RyC0uF6qgD154fEgWueRf8h4vc1/iQEWlzybbSyp5BqzgpcNT+oR0Q3yAcHlB
	sToQGK2p4XGz7dl8PxJv8NE1CZdUHH7TmJxnNG2F39608IxOxaPvJ8wGNui2wv3fATkq2ZywSSM
	x0JTVc3jC09umfugrZM=
X-Received: by 2002:ac8:5755:0:b0:4ee:4a3a:bd1c with SMTP id
 d75a77b69052e-5068124f1eemr38903341cf.63.1770824200237; Wed, 11 Feb 2026
 07:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260211030048epcms1p54c6ed78458f57def8e3163032498ca00@epcms1p2>
 <20260211103243epcms1p2dd304fd11b28df04f4e680e8c90a7fc5@epcms1p2> <207b2879-e022-4b50-837b-d536f8fcabcd@suse.de>
In-Reply-To: <207b2879-e022-4b50-837b-d536f8fcabcd@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Feb 2026 16:36:28 +0100
X-Gm-Features: AZwV_QjAGvi7BqseLa91JoZGgGvgvOjatXS8KhyY5j9-amfhurW9duRWp81Dkl0
Message-ID: <CANn89i+mNojd9mUL_dt_=D+7nZ9xcV96CYJG_LYFmBZDOYUMFQ@mail.gmail.com>
Subject: Re: [net-next,v3] ipv6: shorten reassembly timeout under fragment
 memory pressure
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: soukjin.bae@samsung.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"horms@kernel.org" <horms@kernel.org>, "phil@nwl.cc" <phil@nwl.cc>, 
	"coreteam@netfilter.org" <coreteam@netfilter.org>, "fw@strlen.de" <fw@strlen.de>, 
	"pablo@netfilter.org" <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258302-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3AD1D125BAB
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 4:11=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 2/11/26 11:32 AM, =EB=B0=B0=EC=84=9D=EC=A7=84 wrote:
> >   Changes in v3:
> > - Fix build bot error and warnings
> > - baseline update
> >
> >
> >
> >  From c7940e3dd728fdc58c8199bc031bf3f8f1e8a20f Mon Sep 17 00:00:00 2001
> > From: Soukjin Bae <soukjin.bae@samsung.com>
> > Date: Wed, 11 Feb 2026 11:20:23 +0900
> > Subject: [PATCH] ipv6: shorten reassembly timeout under fragment memory
> >   pressure
> >
> > Under heavy IPv6 fragmentation, incomplete fragment queues may persist
> > for the full reassembly timeout even when fragment memory is under
> > pressure.
> >
> > This can lead to prolonged retention of fragment queues that are unlike=
ly
> > to complete, causing newly arriving fragmented packets to be dropped du=
e
> > to memory exhaustion.
> >
> > Introduce an optional mechanism to shorten the IPv6 reassembly timeout
> > when fragment memory usage exceeds the low threshold. Different timeout
> > values are applied depending on the upper-layer protocol to balance
> > eviction speed and completion probability.
> >
> > Signed-off-by: Soukjin Bae <soukjin.bae@samsung.com>
>
> Hello,
>
> isn't this what net.ipv6.ip6frag_time does? In addition, the situation
> you described could be overcome by increasing the memory thresholds at
> net.ipv6.ip6frag_low_thresh and net.ipv6.ip6frag_high_thresh.
>
> Please, let me know if I am missing something.

Also :

1) net-next is closed.
Please read Documentation/process/maintainer-netdev.rst

2) We do not send 3 versions of a patch in the same day.
Please read Documentation/process/maintainer-netdev.rst

3) What about IPv4 ?

4) Only the first fragment contains the 'protocol of the whole
datagram', and fragments can be received in any order.

5) We do not add a MAINTAINER entry for such a patch, sorry.

