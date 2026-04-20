Return-Path: <netdev+bounces-279894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIDpGEVv5mmBwAEAu9opvQ
	(envelope-from <netdev+bounces-279894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:24:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB251432C6A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA03B30154B0
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD483AE6E9;
	Mon, 20 Apr 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="XqPfhTVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078533815E8
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709440; cv=pass; b=Hq/iKyqRarI+SMaviWzTqUq7NE/55PJKlaDm6m4t0pI1ish6jQWO1ogPmxipeSZYD7WSTsAo+F0aJ/Cpo43w1v2KYudTUqzwzqJfjn/1qnjEHYfDskpUzlORZ2hvwn2WIQFMK6B4rfCXwsbHs7Ktokzznuzg5a7u9kV6fY7pzX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709440; c=relaxed/simple;
	bh=lhCKtHEBVvWKUR6rkYQZu2CCq/FWnWcj/Z981lhq1dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ogn4Y1p7wuFUojxcKv2P5t2e8Rnq0volKxX7HOVaJKOZpW0AdiPT2vxeHqD74ZQpeya9DBTKdiqyhyCQx5PBxUfIYtyk/sE+fekOsrRENcpaXx+BxDdG2DRCp7rca7UIPg8gAQiizj1j1fofhjI9A2SZxt4Hbr18xWy7daef9Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=XqPfhTVA; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38e12c67a6fso33064991fa.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776709434; cv=none;
        d=google.com; s=arc-20240605;
        b=Qs65qT6jGiS0TfVcLS+SsQWjPjXCOxDlEAt25RlcJubOSKbgQSrz9e5oaVzL9jO/9G
         Oz6eqt0WY+j4x/LVkVBaJUsrZMg41bty/zRIJIKGn5HopSby4SeSmz4jk2Hh/zlAUb2k
         mYNmy4hQXZh9L9A18+ZZ5JMZSuxVNobiW0/hd2GRBsu9YTzyVjf0mrxvxfC14xFJ0AAW
         2qMdR1AoKI78s78xoXwNnvnKdhwe4CBChQtrb8Lf4WmcG4JZ0rUiE6AgGflu4LR3+fN2
         krCW9QxUVKoKIg3MHnI8hFo/aHVtOKnhHnxwg6vBq+rLhQcNxZG0dXNMzDVnwsb3bD+O
         wYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2HKdfw2CYPTQe0Vd0EghRqb6t0C7lsRKFA7TevWMWCQ=;
        fh=fQps1BaqHuazUy5Toca1PMvh1MQvE/kzbKiccpHfXMU=;
        b=cz7eVHMPBw6MxeUAHuf2YdVRcq3D/w1rH+Nw4Tcc9WF+4QRK+dEMVOvQto6R760TUk
         FBb3hG91GmoYyifF9hPdkImmVXyRcP8pCmq+pHKVXKS28pJMrK4egIvP7tdHcOpJnjOy
         444UHikmIWCH3RG0WITt5ylGQeQBawy2dUwPmgg5qbfvIl/DBHEzqPvKmYi1HFoIewrm
         LTDq0dey8G7RYZGYdYYlEe03o+vmYooZjbSKskQE4lXp4CWl9Dlc8dL4YRq2+N+RS3sM
         BhAj1GyHE0Zjv4wGrQ3pD1C/pxnOVtW3XS2g36prD2n+rDR93avM0IUsT9OJkmp0VCw2
         WTKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1776709434; x=1777314234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HKdfw2CYPTQe0Vd0EghRqb6t0C7lsRKFA7TevWMWCQ=;
        b=XqPfhTVAT+uX2JylqdXeWqmk+xOKCRfnCgMRjG20p4x9iYeaGGs17adj+ZinAZPWAP
         RuYG1ZpoLaPAyApc7L4Uj0j/nZOLRcSFO60aYVtpy/Ch527v52bMvDKyyoMWDa22UOnj
         eHfrELjr87tCjb79ZKEhQLW7sYfMofHwznaMuxRLWfByk0w0ph85duQTyRuvKRFa3diI
         vNXgkVVjjpzFekvgo1k96Amjc2CWPjvSdsUuQAAaa/H7s2WDGXXDr8986N09LsF2g5Hs
         Q8CXkK/xgQR4XDhPO+R6KwCRVDdMAnoAA33KVp1clqG2PvAV3Ek57HSwavfiqDVNEGwO
         12CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776709434; x=1777314234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HKdfw2CYPTQe0Vd0EghRqb6t0C7lsRKFA7TevWMWCQ=;
        b=P3XayIjhnpJAzRK9fOA9sP+qVl05OeOah6DYWAJUc4ApU8ApF0jVt69QN2Diupvj3K
         LDlOQc2CJjkUTvbHwWMDbA50sYPV2qXN9QqlVs7I9oxPeFHtvd2oNFi52C/Iggy+4lpW
         KbeQwYs6cfkayFxbEXV2q/mI0oB5AEF9FYAveQ2s5AvK5kd0O6N7r7ATXTc6j5oIty3b
         jy6c1J/3pXTtP8+7v+LC2UUoaL9JUSfDP47Vyu0VE7rBqu9PsHzeHtL/vuSrAAsl6kLA
         FQkX2nt3WMk0DuHqfmh1+D4bYqAdtRefbrPsugO45HMQGl6DW/WbR7dBLYeHG4DMC0xa
         aVRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MNnmM9IC2ZJl4E/ZUbF9cmLcoOIn8d+Fm6REpcFLNH8Bsz5HsyoxBSB5r5J7lEyAgYTTM/ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMa1ttFK/+vEogC9gIwmgg/cnO4Qly0X5gaomZtsyRRmKYvE32
	hZevufSmYbwDVP9zO3MRGhd+E8NkZQ6ePdR9eIGt6omXAXJuLtPjsiIQIPqlWi5ejVX1gXMWWEn
	NAWEnmjQVWnyfhfGdF4xsfwZ3dsALfXII9yknC6fo
X-Gm-Gg: AeBDies3b8f26td/2R4i1CZgA/4BvghEByy1COxaa3iMgehUb2+1O3JJsJyrLtv+9ef
	+j0BGqSdhsFk4g2ePSeKNRAVLl+ggzIIZ/nQse4B2po8y3inAVWLU9j1rONJh4I8o68Z17VdoR/
	CoPT4yeZwSc6lMT8/lxiiXijbr2GlqYorJTv70G2uVCWlGSPT0RdA1VYc5spLrli813iN4pVImG
	BQVDF7tF88e8dNP8lTxTLK17hto+O/FlfcgTLoiQwO5oQ8x5n7ZaK6IjYiAvv7hg1t3vS6YZgWq
	qybWQC8bDLde0TlKvjfOpn2FlFaK+PN2yqJ6rZLPyOJaPXpyKc9ezVbIUHFW0oaHVdEvYAZz0pH
	pw9k+TmM=
X-Received: by 2002:a05:651c:502:b0:38e:be42:57b6 with SMTP id
 38308e7fff4ca-38ec781dca4mr43326621fa.9.1776709434337; Mon, 20 Apr 2026
 11:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314175124.47010-1-tom@herbertland.com> <20260314175124.47010-11-tom@herbertland.com>
 <20260317153222.GD1710951@horms.kernel.org>
In-Reply-To: <20260317153222.GD1710951@horms.kernel.org>
From: Tom Herbert <tom@herbertland.com>
Date: Mon, 20 Apr 2026 11:23:42 -0700
X-Gm-Features: AQROBzAO8qVbVYaOWD-eJMJkiMfOzUl1K5pFS49MKjBbuxDbUL530-eZ6sJuM6I
Message-ID: <CALx6S348AJZe_HCvk0jrdjYQ=uX28DSzO=qtsKtzs5NjTai0yw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 10/10] test: Add networking selftest for eh limits
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	justin.iurman@uliege.be, willemdebruijn.kernel@gmail.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-279894-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shellcheck.net:url,eh_limits.py:url,eh_limits.sh:url]
X-Rspamd-Queue-Id: CB251432C6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 8:32=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Sat, Mar 14, 2026 at 10:51:24AM -0700, Tom Herbert wrote:
> > Add a networking selftest for Extension Header limits. The
> > limits to test are in systcls:
> >
> >       net.ipv6.enforce_ext_hdr_order
> >       net.ipv6.max_dst_opts_number
> >       net.ipv6.max_hbh_opts_number
> >       net.ipv6.max_hbh_length
> >       net.ipv6.max_dst_opts_length
> >
> > The basic idea of the test is to fabricate ICMPv6 Echo Request
> > packets with various combinations of Extension Headers. The packets
> > are sent to a host in another namespace. If a an ICMPv6 Echo Reply
> > is received then the packet wasn't dropped due to a limit being
> > exceeded, and if it was dropped then we assume that a limit was
> > exceeded. For each test packet we derive an expectation as to
> > whether the packet will be dropped or not. Test success depends
> > on whether our expectation is matched. i.e. if we expect a reply
> > then the test succeeds if we see a reply, and if we don't expect a
> > reply then the test succeeds if we don't see a reply.
> >
> > The test is divided into a frontend bash script (eh_limits.sh) and a
> > backend Python script (eh_limits.py).
> >
> > The frontend sets up two network namespaces with IPv6 addresses
> > configured on veth's. We then invoke the backend to send the
> > test packets. This first pass is done with default sysctl settings.
> > On a second pass we change the various sysctl settings and run
> > again.
> >
> > The backend runs through the various test cases described in the
> > Make_Test_Packets function. This function calls Make_Packet for
> > a test case where arguments provide the Extension Header chain to
> > be tested. The Run_Test function loops through the various packets
> > and tests if a reply is received versus the expectation. If a test
> > case fails then an error status is returned by the backend.
> >
> > The backend script can also be run with the "-w <pcap_file>" to
> > write the created packets to a pcap file instead of running the
> > test.
> >
> > Signed-off-by: Tom Herbert <tom@herbertland.com>
> > ---
> >  tools/testing/selftests/net/Makefile     |   1 +
> >  tools/testing/selftests/net/eh_limits.py | 349 +++++++++++++++++++++++
> >  tools/testing/selftests/net/eh_limits.sh | 205 +++++++++++++
> >  3 files changed, 555 insertions(+)
> >  create mode 100755 tools/testing/selftests/net/eh_limits.py
> >  create mode 100755 tools/testing/selftests/net/eh_limits.sh
>
> Hi Tom,
>
> Shellcheck flags several instances of the following:
>
> - https://www.shellcheck.net/wiki/SC2154 -- ns1 is referenced but not ass=
igned.
> - https://www.shellcheck.net/wiki/SC2086 -- Double quote to prevent globb=
ing ...
>
> In the case of SC2086 I think this can be trivially addressed by adding
> double quotes.
>
> While I think SC2154 should probably be ignored using
>
> # shellcheck disable=3DSC2154
>
> We're trying to make new scripts shellcheck clean, so I'd appreciate it i=
f
> you could look into this.

Okay, I'll fix the double quotes.

>
>
> Also, pylint has also something to say about this patch.

I don't believe those warnings aren't critical, and the score is a
high as other python files in the directory.

Tom



>
> ...

