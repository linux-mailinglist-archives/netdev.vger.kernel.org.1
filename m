Return-Path: <netdev+bounces-254034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGeaKrVGeWlWwQEAu9opvQ
	(envelope-from <netdev+bounces-254034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 00:13:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 255839B56C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 00:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1031D30120E6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5624E2EBDD0;
	Tue, 27 Jan 2026 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upoWD/Be"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72382BD580
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769555635; cv=pass; b=q7qVHWYhIxhQOsAKcFxV+l0lgGUdf4kIALoyTn1cFwFiFUwOBSgmTcvhrst/7cBA3+1fRzBhAF4mTWp2BxvqV6+H9ffS/kcnKFmBzbO8DXTnQ0i1DmSFTnEpgd1lFZjnhY4l2zw/OODD0tr59cexCVKFAPk0fOIrwKBO8TEcCCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769555635; c=relaxed/simple;
	bh=xb40snI4cL8+jHGEewGctsfuifnXr+1DbEvvig+jeI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWLIv/Zfrr9ScbqADHEUefEUKyzcfLyAPPEdUjfMu3bTEsKhSe9toupUoHYtXHuh7n+QW5ueZq1or9RzxcFLeiq4l3DT0zF3wKY6LvmU/FmPI5NS5QEOmHzzryE0qzZwsum7T4DmrBMG5CIPtCN+VUlwJPtZO/3fuIFHPkLnZ9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upoWD/Be; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b71515d8adso6085736eec.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 15:13:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769555633; cv=none;
        d=google.com; s=arc-20240605;
        b=OSYcX6fDAkFjBG/x62RLMlncr4RRhr/Gvdxkv2eyghwxxeX0zUaFakmYWnJydWbk+s
         kQZdBuMBhTDLX0K/E+Z7O86iKHQjK9gsniFWv3NPJhV6bc3Lg4I+FiZX54tUvJAkkL+t
         pBuWbwGwFktRmzIU+3nbz+J8BfoQoXukIuDbeuGjn449Y0CL7SOfiBx682pOphHTqI9B
         1ABO7s/qTIxDFuFrdpH14L2jsXZ+2MFZVvu71MPNT7iR2l2vKcx7/ZW7M8iXAwqHb21p
         BiFvHVGaPuIOzGpVmVRS6XWLgiEhWQda433C9l6jxXHHDfVCG/LvejwQmJkZKrtMoZib
         uP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mtT0BqTp2zcqo5ksB90ktPFH8D1L2OPW30rexRlRuNU=;
        fh=ERvK3ySukd0GCMIZiGZoltaqkyO58/doqiIT1mQl9NM=;
        b=j4I1UHzNSNR3P2bI6KAWpDeH3yIzdNubtkmt9ktcdIsrBQAy39kGZL60Kl8X3clsra
         Z+ro809u2v9/n0gpsVtw8XYuNBn6W3aMvbIBeK3dsgx7SMo8H/Xs0JQc2U56YIxCHE1y
         msliXPflK8A0QpXVxo/FUcdN9nRVQUaY4q3qZTNx8DfJZZZEM0vo+s4Qs/EXGuUIurpM
         s+V74BHgTRbs9CVFNf5Tqvoe61cyBaB9w8giI7Ul6iKh3AFef3mod2UziyVuXRaT9n5E
         M33FB+mUhuUrNWokyz5zGjCFH4TtR3QB/Zz1VFoj/7Tf+DJEiiPAhb1tvqvG5aZC+7FP
         aOxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769555633; x=1770160433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtT0BqTp2zcqo5ksB90ktPFH8D1L2OPW30rexRlRuNU=;
        b=upoWD/BeMD0bq4Qet3bmcLXuRwIzFvCNVBX8fsJU0+ycTrs3RXkWpTfFgG0hKieN35
         nktAN3Q98j5gKYvVachbDbbQD50FM51TA+wx1Y7Ekhcplba+ZRyegBwIjhsAtIo4mY/G
         vBnIicPXHkhEKwXmhaXgM/glqmwsGw/SxrPwJyVVcZUhUnvxOUcYPllmvUexZwlBic7/
         L9IgMZr3KW/oxSyNvCuZA0Ksz1245qMwsKCJdLpb2jUSzFsRh0B1HYzcgtf4pEukD3uW
         yOPYN/OTE/RPg41bTLTVdbOCQ3fp+Bsbp6XTSOMJpHQBfX/UMMBXwAfgWnfGGHLe8Oze
         uoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769555633; x=1770160433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mtT0BqTp2zcqo5ksB90ktPFH8D1L2OPW30rexRlRuNU=;
        b=okp7fBz6ncsvEcu3OW3b+caRifGxGjFju5+QN3HR7ULy1Qz5YsKC5teUCihpvvTXDc
         cbM4dehnDYFgAynIkNU9FE5SEVt7ERlbyznVV6C0DVqolPAfjyhHQXOgMJ450DlJdZ8H
         Qn8jEX0ldj8VqV0/SNcz+i4Q1GgopXLoD87BvfQu7zEtujCYEuJ31AZzRyWG6boCz4V9
         h9su7sYUJE9icLw32jplaF/kchzfegCnnSZbd15lJAgxobYaguMdpd+5ShHAeD2qUfX0
         sq7ZV/PGIS12hhe9oEyZNgKn0vPcS3/z76TsIWkKjpWZPS4N7LjfM4+52BlD683m42P2
         +C3g==
X-Forwarded-Encrypted: i=1; AJvYcCVj//hckYQUEhJIRowZ2yQx1FLkjufir+QHNdKEdIqXSBbcjUJDpi3qhQ0Zk3o2NoD7ovS8TF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLzdxuwcT8VaAReWWuuyCfvzNiRBRjwLecwraflXtwrDmP0ev
	AfFe2lhAMBQyUDQyimLxQSrTMHPB2rrbGGLbodYFmbMKZ+3HEgnR3FoMYwhexjLlvMf6WC8dU2A
	EzFzgtntmqyiv9piUkn3pw6FJP7nErbQErXf0ohYu
X-Gm-Gg: AZuq6aLIM0qycDvmXSb/w/wonjHOysO6eA0QHmG6pJldCS6/EgaEJG7oSSOobNvTwFE
	3CmTANl3Alf36QYV40ffN6awo6vu8srqs6DC1oaI4aIThv+CHx1PCFvV0i4yGEDj14SJu07Edl9
	BxAuEYD89HcrZ85+iPxUXDxdX5VQ4QXZH0q1yjlKqkuj0NfassfnZE3fzyG7YM9hO5K8MGvb/v6
	2QVvOduQVWzyHkUEdOROlNUs3ruAx/WfY3IpthPVmbXocmkhjpuRqqP29Y7SpYWMPrLEHI=
X-Received: by 2002:a05:7301:fa8b:b0:2b6:c617:f79d with SMTP id
 5a478bee46e88-2b78d8a51admr2214320eec.13.1769555632506; Tue, 27 Jan 2026
 15:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121160458.990785-1-yyd@google.com> <20260121160458.990785-2-yyd@google.com>
 <c5ba02dd-e81f-4590-9e35-90c9b2c33bee@engleder-embedded.com>
 <willemdebruijn.kernel.13b62cc180aaa@gmail.com> <9d21ddb4-5e7d-4dfa-9ee4-ecdf73499f5b@engleder-embedded.com>
 <willemdebruijn.kernel.976a69fefaaa@gmail.com>
In-Reply-To: <willemdebruijn.kernel.976a69fefaaa@gmail.com>
From: Kevin Yang <yyd@google.com>
Date: Tue, 27 Jan 2026 18:13:41 -0500
X-Gm-Features: AZwV_QgvnMYcNLaMhTKWiNeZ2Q7YH8Wt0EP68NeiZajpY0HClPpXRXmJQlybW0E
Message-ID: <CAPREpbZpjwpUkY11Qz_xbVbCm44DZw=3Z2GYu=K93z+L-_4EhA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: extend ndo_get_tstamp for other
 timestamp types
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>, Jakub Kicinski <kuba@kernel.org>, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Joshua Washington <joshwash@google.com>, 
	Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254034-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yyd@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[engleder-embedded.com,kernel.org,vger.kernel.org,google.com,lunn.ch,davemloft.net,redhat.com,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 255839B56C
X-Rspamd-Action: no action

Just to clarify, the ptp vclocks approach is not contradictory to this patc=
h.

I think converting the timestamp should be a net_device ndo function. Since
-  a TCP socket may receive packets from multiple net_devices
-  only the driver is aware of the device clock's details and whether
  a conversion is actually required

That conversion is implemented per device:
-  Some devices can identify the correct vclock and call
ptp_convert_timestamp(&hwtstamp, vclock). This is a valid approach,
but it requires the system admin to run phc2sys to sync the vclock to
REALTIME(or MONOTONIC), alongside necessary lookup infrastructure.
-  Some devices may already sync their clock to REALTIME natively.
In this case, hwtstamp is returned as-is without conversion.
-  Some devices may handle conversion internally without using PTP.
This is the case for our current GVE patch.

With that, I think this patch (extending ndo_get_tstamp) has value
regardless of the specific driver implementation.

As for the second patch and the question of why GVE does not use vclocks:
The current GVE patch is simple and self-contained. Switching to vclocks
would likely require adding PTP infrastructure to look up a vclock without
user interaction, which complicates development compared to the current
approach. Also, ptp_convert_timestamp involves a mutex lock, this might
raise performance concerns since the usage is on the TCP RX fast path.

On Sun, Jan 25, 2026 at 4:41=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Gerhard Engleder wrote:
> > On 22.01.26 23:28, Willem de Bruijn wrote:
> > > Gerhard Engleder wrote:
> > >> On 21.01.26 17:04, Kevin Yang wrote:
> > >>> Network device hardware timestamps (hwtstamps) and the system's
> > >>> clock (ktime) often originate from different clock domains.
> > >>> This makes it hard to directly calculate the duration between
> > >>> a hardware-timestamped event and a system-time event by simple
> > >>> subtraction.
> > >>>
> > >>> This patch extends ndo_get_tstamp to allow a netdev to provide
> > >>> a hwtstamp into the system's CLOCK_REALTIME domain. This allows a
> > >>> driver to either perform a conversion by estimating or, if the
> > >>> clocks are kept synchronized, return the original timestamp directl=
y.
> > >>> Other clock domains, e.g. CLOCK_MONOTONIC_RAW can also be added whe=
n
> > >>> a use surfaces.
> > >>>
> > >>> This is useful for features that need to measure the delay between
> > >>> a packet's hardware arrival/departure and a later software event.
> > >>> For example, the TCP stack can use this to measure precise
> > >>> packet receive delays, which is a requirement for the upcoming
> > >>> TCP Swift [1] congestion control algorithm.
> > >>>
> > >>> [1] Kumar, Gautam, et al. "Swift: Delay is simple and effective
> > >>> for congestion control in the datacenter." Proceedings of the
> > >>> Annual conference of the ACM Special Interest Group on Data
> > >>> Communication on the applications, technologies, architectures,
> > >>> and protocols for computer communication. 2020.
> > >>>
> > >>> Signed-off-by: Kevin Yang <yyd@google.com>
> > >>> Reviewed-by: Willem de Bruijn <willemb@google.com>
> > >>
> > >> Like Jakub in his reply
> > >> https://lore.kernel.org/netdev/20260119115710.6fdde8c0@kernel.org/
> > >> for me also the question why this is a driver implementation came to=
 my
> > >> mind.
> > >>
> > >> With vclocks it is already possible to get timestamps for arbitrary
> > >> clock domains in parallel. So it is already possible to synchronize
> > >> the hwtstamp to CLOCK_REALTIME, CLOCK_MONOTONIC, ... in parallel.
> > >> Therefore, user space synchronisation is needed, but e.g. ptp4l does
> > >> a much better synchronisation job than your solution.
> > >>
> > >> Maybe CLOCK_REALTIME is not supported by ptp4l, because due to dayti=
me
> > >> saving this clock jumps. IMO these jumps will also be problem for
> > >> your solution, as it will lead to wrong delays two times a year.
> > >> So usually CLOCK_TAI or CLOCK_MONOTONIC would be a better choice.
> > >>
> > >> To sum up: IMO you suggest a driver specific in-kernel solution wher=
e
> > >> already a driver independent user space solution with higher accurac=
y
> > >> exists.
> > >
> > > Definitely a promising alternative.
> > >
> > > With multiple netdevices, a TCP listener socket may receive packets
> > > from all devices. This would need new infrastructure to lookup the
> > > correct vclock for a given net_device, cannot hardcode a choice with
> > > SOF_TIMESTAMPING_BIND_PHC.
> > >
> > > And this needs to happen for every packet, so with minimal overhead.
> > >
> > > Though for established connections the expectation will be that
> > > packets generally arrive on the same netdevice. Bar infrequent path
> > > changes such as from sk_rethink_txhash on the peer. So there this
> > > value can perhaps be cached.
> > >
> > > It would still have to be learned by the kernel, no explicit
> > > setsockopt.
> >
> > Maybe it would also be an option, that the kernel learns with which
> > clock domain the timestamps of the PHC and vclocks correlate. Then
> > the TCP stack could calculate the delay if it finds a valid e.g.
> > CLOCK_MONOTONIC timestamp in the packet. This would make the
> > TCP listener socket independent from the devices. Just an idea, without
> > thinking about implementation details.
>
> I think we're on the same page.
>
> - use the existing vclocks
> - look up the right vclock based on the original incoming iface
> - cache this known clock with an established socket
>
> But I also have not looked at how/whether the lookup infra can be
> implemented to find a vclock automatically, i.e., without userspace
> admin.
>
> In some cases shinfo hwtstamp raw format may actually be the
> CLOCK_REALTIME that TCP requires. But if the raw clock is not
> realtime, we'll have to adjust based on timecounter/cyclecounter.

