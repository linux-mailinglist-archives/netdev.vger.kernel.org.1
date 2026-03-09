Return-Path: <netdev+bounces-265403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLMfMMR/rmlfFQIAu9opvQ
	(envelope-from <netdev+bounces-265403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:07:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2187C2354B9
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47EE9300D304
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6F736B066;
	Mon,  9 Mar 2026 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llc6YFoE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145563446DE
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043641; cv=pass; b=R8KzpCCcmVwMA7Qb7iG/bPiVhUNL2IRzwMitPgfjORJ1apxcve/ZoWudrEz0kOpFuVVkYENochH6qCdEdw0Je69zhh45mzCGEcJWdLQAXB2UUpzsT+EfAGKK9L/tT4BaN1jiVUkRKgVAMg4i+SFN0o8uLHDlG4CMY57tAqFBfEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043641; c=relaxed/simple;
	bh=0fy5mx3dklyKWMbAK7fal2ijQ7z4ajqgv9ZSVKHtp8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3WPHVrSjj22gpb2YjobODY67k2t6qA+utoctit2gOcOBHqByqA1p+X79o7tPyEduPm5vsxNfYTQumPmaZ7C0aChiAuHtpC2OOL0zpWbZFBA6/ipv2cGri2VW/Ei9zbL23MIkkqGJE1HMRssMhx/v5YLVpluYzfkJTo+Wq3l+wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llc6YFoE; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad79df972so10599769d50.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 01:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773043638; cv=none;
        d=google.com; s=arc-20240605;
        b=aSp3oBh1RH+SSS16NjjWffudf0L0lZaUvr7cvjCyRpkwtTIIvZkuwLO4nGcPPAzfhc
         iV5Ioazw0qB9vkKUAnaVEiJswvBMGKKZgxn6IEvgsQmuRoB+1+MkqyGLws/1kUtOTEDU
         UwYQOIzWhEU6RDyRcP0EhvudAmnJfiICVSH2vi7NJm5oPHGZdEW+Pn0KHbZcGdbpnplj
         fcxbE5CUu6ThOaDC3h8aliIVsFM+kUklH9mnc8gNwrqeb1k+cDDZgSZUFWXkTV7dmCfF
         eKQwioyEDtn6VOoPpvmr6m4ZbE7VvMDYH2bfFflvkLZFGe0wkiKYAYQILMy+wZaCsE6K
         tnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=68Ca4BSVVxuxFs5jDFdJ1MgaPQvYkTcuBkxjWIyxlPY=;
        fh=7xhL5l6MUSE80J3+l5C+3mIDSvbMjYmI2qhByqHYow8=;
        b=PqLi25gL/R2zRbEXt6GV6SodeSe7cBCUnriZq0b6cKf7L4jqEzlW6cl4vKC5naUDH+
         IwycbK0oTPGSn316hmOnp1rDA/PtGm34Fou86Ckgltgb0LZiHRg96UIbVY0H55sE/JxR
         YVYhy+aoV73PjtJ0cLjyBKsQcFq9F28KB7Z9FyeqIk7BV0LUpIjKRWicDV6AHf+zQ6bS
         gYGX75BBQ4+8NaDOe81KCuS9eSBl9nNHnOhSkuj7TS9S9CNnRNHzH6ZzjDqnDtrpYL/4
         ixJeL6VYLOKcwvE8qgfNQl4+qQbJDkLRKFxcCe5Q3BUn5gOK4wgO1OUccjOJDqcrnZpm
         vHbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773043638; x=1773648438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68Ca4BSVVxuxFs5jDFdJ1MgaPQvYkTcuBkxjWIyxlPY=;
        b=llc6YFoEgf1o+oZ6OEIKa7pU5NGmCckF4z31LVQKe95q7nCQx41/5ycEeaXxv55sXT
         Fi7FxmO9l3cSW5sAdoMELS+7qVScpZGPs6VIZ1aX/ohU+TB4kIwwsaqJG1NDtZY9a0L7
         zVY+IEGKM8FK3TkYVwOtoQJL5/XAHhpLgVhNHm00Cvqa2JLMrGRHljy3LZpUFiyRI6ty
         jeCEB44E7fCKM2DPesvua0/xkJdN4PccIHQicYa2sw8KTkxHs5WmSXcSkDqPZJHCq4Ah
         iCjZ3dcVl/p4rvUQ4VAoHCGDIAOlvSIJQraA8qELfyyn9HP4bPl12eA2T/RnJ4NHEgUK
         gm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043638; x=1773648438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=68Ca4BSVVxuxFs5jDFdJ1MgaPQvYkTcuBkxjWIyxlPY=;
        b=M9/kyfiHwiDCbjhdd928JwiMoSeNDTAVHLi040dgM7NVSkxuaQvRSzXq2vnBQ96yrM
         pKaZq228HWOrQz4byozoQXNs1a3ntHdRaeGd2tqAeVCmyMwkfoBQnt+R6HGyAur7AMC+
         x6ksH3ph6bHFDNPRll+sRnJj8k83XGAWcED2dNVEGHS5mM1GBvCgVve/EHdAkevdZ8s8
         8u0Zn+x2HLu/3ITJZU2rIv/kxgHyzw3rMgCBXnf3rYgfIhq9yvTBFJ7UvgKLH6/ie0oz
         igq/Sn/3fZstcxWW//AO+KBRLW33zohrB96BCwz3JtnIBUslx3amwaa10wxObkr6qdtA
         QFIw==
X-Forwarded-Encrypted: i=1; AJvYcCV0010bQEzUt1EV2wqS8l+N4ojOafTL3TyJhNote8IQ4a8Ahfef7jk1moMQwxC6vvij/sO5KOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZJwrrmI0i/sO/2yJ72M9P2E7pn+zgpkw1lAW/+GgwXxH53ud
	s5vQjkdowtQxk7HZsNBN/2ev3E/bp9B4djmEUlqP1pAQlLLIdgnE5b7qTb9qNFwolNdejZrpiA2
	0dUrb5rVb9JnpcitTytopgk7ylnQ7plk1LaZU
X-Gm-Gg: ATEYQzwRRKDc/AtpX+VoH6uEEYfuLNCS3ldHCzYuvduipAHBWoGvXrPBrcLuObTEDDO
	NO9KciLKSQajY1imKJkNElnWahVrB9Husm1fLfSYiBX3PHS994CMHpseZUJ0yeTrFoVVe5HBnDX
	RNUeRlVsyoUXlLcqs6weFu11lCx/Q/UOd5K9K0HBtXG++Fy5bL946v9O8NUPeNFq8sQHM+CPXOC
	5BB3lzsWpjQb1n+P+k7WwDUX+DjG/tG5kMHb7FHvsl5RpQifDYMKweJNtbeHymFLOMBcCzwJUaF
	hEgOh1TVI2d1tdyT
X-Received: by 2002:a53:b465:0:b0:649:cf3f:b318 with SMTP id
 956f58d0204a3-64d14280ef0mr7957413d50.54.1773043638016; Mon, 09 Mar 2026
 01:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772853341.git.daniel@makrotopia.org> <d9d8e6058e635c1fdd4689c875204d48d0235295.1772853341.git.daniel@makrotopia.org>
 <3bee5ef1-0692-4779-832f-193017810c38@gmail.com> <aa2TYxEHQ91SbT3A@makrotopia.org>
 <CAOiHx=n9_asSiAhB=aZKRenh6BsBAYP_3i7WxfBsbUBDz3BrWw@mail.gmail.com> <aa4OJ7hkqoR6oDxZ@makrotopia.org>
In-Reply-To: <aa4OJ7hkqoR6oDxZ@makrotopia.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 9 Mar 2026 09:07:07 +0100
X-Gm-Features: AaiRm53OMVwjysuyuRfmXH4LasT_kzVKUBvYFj7WjPI6COuaEVIe6H4k3Kro_oo
Message-ID: <CAOiHx==-3Wa54Y+CbkVjwqDwjHk4Rf-uy9ujwc77tQn3kbN9sQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dsa: tag_mxl862xx: set dsa_default_offload_fwd_mark()
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>, 
	Cezary Wilmanski <cezary.wilmanski@adtran.com>, Liang Xu <lxu@maxlinear.com>, 
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>, Jose Maria Verdu Munoz <jverdu@maxlinear.com>, 
	Avinash Jayaraman <ajayaraman@maxlinear.com>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2187C2354B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265403-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,makrotopia.org:email,local_termination.sh:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 1:02=E2=80=AFAM Daniel Golle <daniel@makrotopia.org>=
 wrote:
>
> On Sun, Mar 08, 2026 at 09:15:42PM +0100, Jonas Gorski wrote:
> > On Sun, Mar 8, 2026 at 4:19=E2=80=AFPM Daniel Golle <daniel@makrotopia.=
org> wrote:
> > >
> > > On Sat, Mar 07, 2026 at 10:57:56AM +0100, Jonas Gorski wrote:
> > > > Hi,
> > > >
> > > > On 07/03/2026 04:30, Daniel Golle wrote:
> > > > > The MxL862xx offloads forwarding between bridged ports to the
> > > > > hardware, so set dsa_default_offload_fwd_mark() to avoid duplicat=
e
> > > > > forwarding of packets of (eg. flooded) frames arriving at the CPU
> > > > > port.
> > > > >
> > > > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > > > ---
> > > > >  net/dsa/tag_mxl862xx.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
> > > > > index 01f2158682718..c02f69de61cbb 100644
> > > > > --- a/net/dsa/tag_mxl862xx.c
> > > > > +++ b/net/dsa/tag_mxl862xx.c
> > > > > @@ -92,6 +92,8 @@ static struct sk_buff *mxl862_tag_rcv(struct sk=
_buff *skb,
> > > > >     skb_pull_rcsum(skb, MXL862_HEADER_LEN);
> > > > >     dsa_strip_etype_header(skb, MXL862_HEADER_LEN);
> > > > >
> > > > > +   dsa_default_offload_fwd_mark(skb);
> > > >
> > > > Does the switch (by default) also flood link local traffic (e.g. ST=
P, LACP,
> > > > etc)? If not, you should not mark these as fwd offloaded.
> > >
> > > No, it doesn't. Testing revealed that apparently it silently consumes=
 them.
> > > I assume we'll need something like
> > >
> > > if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
> > >     dsa_default_offload_fwd_mark(skb);
> > >
> > > similar to tag_brcm.c, right?
> >
> > Yepp, that would have been my suggestion :-)
>
> Ok, I'll do that then.
>
> >
> > > > Is there is a bit in the header that says whether a packet was floo=
ded or
> > > > trapped that you can check?
> > >
> > > Earlier testing showed that frames arriving at the microcontroller un=
der
> > > some conditions are relayed to the DSA CPU port -- and are destinguis=
hable
> > > as such. However, there is not bit directly indicating whether the pa=
cket
> > > was (also) flooded already.
> >
> > So you know if they were copied to the cpu port due to some rules, but
> > not if they were snooped or trapped?
>
> I haven't found any details about that documented, and all I can say
> is that in some cases (some of the IEEE1588v2 frames generated by the
> local_termination.sh selftest, for example) the microcontroller seems
> to send an additional copy of the frame to the DSA CPU port using
> fields of the 8-byte tag which usually aren't used -- and that's why I
> even noticed them. The initial driver now merged upstream disabled the
> microcontroller SDMA and FMDA, effectively disconnecting it from the
> switch datapath, so it would shut up, and this effect can now longer
> be observed.
>
> Now, when testing if link-local frames would be forwarded I noticed
> that there is a set of default rules instatiated after reset which
> trap link-local frames to the microcontroller port. I suppose it could
> also be setup to snoop instead of trap by manually erasing these PCE
> rules and setting new ones instead. In this case, however, there would
> be no way to tell from the frame received on the DSA CPU port if the
> frame had also been sent to the microcontroller.

For dynamic configuration you would probably need to then check the
destination address, check if snooping or trapping is configured for
it, and then set (not) mark offloaded accordingly. While linux allows
you do dynamically configure some of the groups between
flooding/trapping, I'm not sure if this is propagated via dsa or even
switchdev.

I suggest sticking to the default of trapping and not marking as
offloaded. It's much easier to flood in software if needed than the
other way round.

Best regards,
Jonas

