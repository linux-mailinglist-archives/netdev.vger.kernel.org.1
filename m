Return-Path: <netdev+bounces-277788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDNUO6aW22n1DgkAu9opvQ
	(envelope-from <netdev+bounces-277788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:57:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8793E3E2D
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C510030028F4
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0285837B03B;
	Sun, 12 Apr 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkaSk7Ou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8B379990
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998623; cv=pass; b=KC+wP7M2bow7sBwm768CAaFUo+A/dNsFmpdm9e72fUL4w273N4lD6S0pEbHfy9hFwOy86laYtnzNqk7TYCAwYFFiV98t80MvSUY9uZLmAA8+cK1GIbx0NHv/pdRQ7c5NR4swXEwQc8puj6vxGPqpZCHQKErBehG1cgnYcHMPdhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998623; c=relaxed/simple;
	bh=qfPYmJHnxmRT9cVmnzYs/e4B/gEH62x/Gcw0W4+P+18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRxXL+0SaLhighbG2yM6rvZlVrj87R5DJV9RVBYvxMpB/raijLZq/Cr0PQRNC4cMh0OJy2s4bJrdHhtZE7/uobiEJ/5uiJCo+H4G9c49QnKDGQ7bXSLvUNNlH0u2iM5ZvarBUtLXXreVtzA3pMNbocQ3sbol+nfL8zASjOyRlN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkaSk7Ou; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso40808016d6.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 05:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775998621; cv=none;
        d=google.com; s=arc-20240605;
        b=XWo4B3JRMXnYEFi54IzJhtbE58gGngxR57SotjnHgFsGJQrldcTbZoLUWN7Cdvv1xq
         CATbd9wiQgTAc5An8r3GOcGPhNXWtd5vv5GuXCP2YTSvMJgoFIsXG0fEYhNv5W0b8gz0
         k4QX2vNz5frzrDDoBFrKI0DAWmi+7LFJHN2IthVNkU7VsgpGtxt6vfDfVOpkLyx5BY5z
         dD9vah30nnJeePDs5/oZiSpib84JPho0OLzcwyYEXZPLPJYXgHLwDoX/jBoM3xKoG3rw
         qqmUayrAgHyv64xjRhYsjumPr6n/8TAsVA+eVsJTE93ezCKD5ZAHdGRhG/q8h/IG8BN9
         iZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nB3JPzZ6SNvkIS006IVQjbVnUi19aOB/TCAFicSog9A=;
        fh=vdc3oVRrWVNdkF637sUesqLgl3aNv8fv6S9vaWpUE4s=;
        b=kvA4oApe0ezgT8KTx8n1uVE1v72G7VOnT5t14tn9JPZuwAbo9LZRAMV8cHNDCXEYij
         +X0MHHdv5h+Nz2umTdO+idmLnHXsua/Fqxbj9brGhlxFjNP314v2TTnUmWRx0nOa7jSZ
         GmbTPW7bkvfzVDSOK/ZJVfwXVlA9MLWl8XQexO9o11DsdnGAm+hwiR08fnFFcjY1WqBL
         85xXBM2fvuyeAch3tz1lAzh5RdNa781uvAMlMrV3bC5bAzb1ljcRQlLiWrCWKgBSX83z
         I77EGt3kLqCy1paIcWgNGKm5+iP0uvYO6j8g3b+rgSTfL3kdq8zo+3CdiUJFfD2Bqj9X
         UOjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775998621; x=1776603421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB3JPzZ6SNvkIS006IVQjbVnUi19aOB/TCAFicSog9A=;
        b=JkaSk7OuU5V+5LiaR6nvJ2eOkJU+OnNuHRudi2M+ggaVIpLl1+tQPkRgRyBmdvKNtJ
         q7631Z4SsgbOwwWpLTy5Iv6szb2loRiDr34BX4dQXfeG/YyxJ5PeiaP6s2862tpU2mXt
         zr8CybNMMA2KFhKcwrAQBGo8yPe0oAc7JkNvKX2lt/yo3QzXJlkiwYEwAvvcnoOsMe9z
         wm/DFi62LK+CNmgKoea41Y1v81F1BggxQXUkZHah/90ephJ0guRyfnvl6W5pRx1nNNLC
         QBLFBfFbulR/aYcRwJxG+nWVW0mM5jwwP7J24+d097gErfM9M7uiwLlEPJwJsJVGCgOY
         yGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775998621; x=1776603421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nB3JPzZ6SNvkIS006IVQjbVnUi19aOB/TCAFicSog9A=;
        b=NFLKak7J8BsH4V2Vjtjo8PNj8cIZdGTTWMP8zYA73S02BfdTDiDzmnK/8zbpppwm2y
         lAHgRnT2SsZbEVhbfUetbkwVJvF2KbOYULs8aFsd0WjtfbKjHMGON3Z8as0e+v1QUfnq
         x3HmKYq7ZsZq1pJuFMSZUDg2lCX04w95YuIz69uRB94RkZb5yGujyKzCAPaluMae1FgF
         5HdyTdnb2i82vJmL2Cs2D/CnJKNYd78o6Jgaflns8iZlMFPGvvM1sfALsb97f19C4wAN
         vcwHOfbMRoUTDk8PjE+oozrzUV66Mu6TVIuHatPZqJzTaJfYNxhz3++Glk8LZz9du/Ik
         fzEg==
X-Forwarded-Encrypted: i=1; AFNElJ/CwdSVRMNiyIB9fpWddQQrz3pClXmqDD8pMbv8XPRRf9+mjeXMRqznN6/t4jqBabE/r8zN3G0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7es4VFrnDBGTOM89oGTJReCVhwEdHZwtQhYGxxF1ElOqSQfsO
	/vjptme5toRKbrkAvsvFQqpZiSrdCMXCO4dOXeiQDWMAkQTa0J8C4WyU2QDNVB+DAo3rjTBoufM
	wDCFJFcWnfYF/1eL0TlrX8aSfxiwkYTM=
X-Gm-Gg: AeBDiesPl30zWHyr3CmIApss4S/Hmrk5NRuWw+w0t9YzYsFCZO8es9hX3hwJ6kt7rGV
	X2jwaJHAofwyQE1rH34x1p77stgVZxCDQEQxTBjunJCKgTpG5EBfqyfYoPVuo3L1tWGaG6B/FyC
	h359m/BfDpqA5FixffXTkbByobxI6y0KqGChui/hKolfiDTWFCK4W+Z8d1gDOQPAdPVKv1AYaGE
	CkqZly4ZTpmG/ruCXlfry3y5vqU0lbUHNwqQpjwU0IIw2LkA4wheWB94asSk8x3GA3anfX4eEnL
	yj86cn4=
X-Received: by 2002:ad4:4ea1:0:b0:8a0:44bd:57d8 with SMTP id
 6a1803df08f44-8ac8623d429mr167289366d6.50.1775998621324; Sun, 12 Apr 2026
 05:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410145448.38253e3c@kernel.org> <20260410221220.1708137-1-kuniyu@google.com>
 <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org> <2026041135-shindig-trekker-5d06@gregkh>
 <b9355e3c-9252-4dd7-b7ed-dff13e3b2c8b@blemings.org> <2026041124-hyphen-circulate-34ae@gregkh>
 <3cd91fbc-d3a9-431e-b915-58e851c7df9f@blemings.org>
In-Reply-To: <3cd91fbc-d3a9-431e-b915-58e851c7df9f@blemings.org>
From: Chris Maness <christopher.maness@gmail.com>
Date: Sun, 12 Apr 2026 05:56:50 -0700
X-Gm-Features: AQROBzDu5TKgVs83Z1LWXJRlNPDBrABRy3VOJf1yI4YJC2vIIt_n8WeMz8OO5kU
Message-ID: <CANnsUMFVg9nZnJ_He38O9Ui1YUM_Je7MGO-y_J+oW=TG3jV1bA@mail.gmail.com>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on incoming frames
To: hugh@blemings.id.au
Cc: Greg KH <gregkh@linuxfoundation.org>, Kuniyuki Iwashima <kuniyu@google.com>, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org, 
	workflows@vger.kernel.org, yizhe@darknavy.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277788-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophermaness@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,blemings.org:email]
X-Rspamd-Queue-Id: EC8793E3E2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for your work, Hugh.

-73 de Chris KQ6UP

On Sat, Apr 11, 2026 at 7:33=E2=80=AFPM Hugh Blemings <hugh@blemings.org> w=
rote:
>
>
> On 11/4/2026 18:58, Greg KH wrote:
> > On Sat, Apr 11, 2026 at 05:24:17PM +1000, Hugh Blemings wrote:
> >> On 11/4/2026 15:50, Greg KH wrote:
> >>> On Sat, Apr 11, 2026 at 08:25:19AM +1000, Hugh Blemings wrote:
> >>>> On 11/4/2026 08:11, Kuniyuki Iwashima wrote:
> >>>>> From: Jakub Kicinski <kuba@kernel.org>
> >>>>> Date: Fri, 10 Apr 2026 14:54:48 -0700
> >>>>>> On Fri, 10 Apr 2026 14:30:42 -0700 Jakub Kicinski wrote:
> >>>>>>> On Fri, 10 Apr 2026 07:24:36 +0200 Greg Kroah-Hartman wrote:
> >>>>>>>> On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
> >>>>>>>>> Or for simplicity we could also be testing against skb_headlen(=
)
> >>>>>>>>> since we don't expect any legit non-linear frames here? Dunno.
> >>>>>>>> I'll be glad to change this either way, your call.  Given that t=
his is
> >>>>>>>> an obsolete protocol that seems to only be a target for drive-by=
 fuzzers
> >>>>>>>> to attack, whatever the simplest thing to do to quiet them up I'=
ll be
> >>>>>>>> glad to implement.
> >>>>>>>>
> >>>>>>>> Or can we just delete this stuff entirely?  :)
> >>>>>>> Yes.
> >>>>>>>
> >>>>>>> My thinking is to delete hamradio, nfc, atm, caif.. [more to come=
]
> >>>>>>> Create GH repos which provide them as OOT modules.
> >>>>>>> Hopefully we can convince any existing users to switch to that.
> >>>>>>>
> >>>>>>> The only thing stopping me is the concern that this is just the s=
oftest
> >>>>>>> target and the LLMs will find something else to focus on which we=
 can't
> >>>>>>> delete. I suspect any PCIe driver can be flooded with "aren't you
> >>>>>>> trusting the HW to provide valid responses here?" bullshit.
> >>>>>>>
> >>>>>>> But hey, let's try. I'll post a patch nuking all of hamradio late=
r
> >>>>>>> today.
> >>>>>> Well, either we "expunge" this code to OOT repos, or we mark it
> >>>>>> as broken and tell everyone that we don't take security fixes
> >>>>>> for anything that depends on BROKEN. I'd personally rather expunge=
.
> >>>>> +1 for "expunge" to prevent LLM-based patch flood.
> >>>>>
> >>>>> IIRC, we did that recently for one driver only used by OpenWRT ?
> >>>>>
> >>>>>
> >>>> If the main concern here is ongoing maintenance of these Ham Radio r=
elated
> >>>> protocols/drivers, can we pause for a moment on anything as dramatic=
 as
> >>>> removing from the tree entirely ?
> >>> Sure, but:
> >>>
> >>>> There is a good cohort of capable kernel folks that either are or we=
re ham
> >>>> radio operators who I believe, upon realising that things have got t=
o this
> >>>> point, will be happy to redouble efforts to ensure this code maintai=
ned and
> >>>> tested to a satisfactory standard.
> >>> We need this code to be maintained, because as is being shown, there =
are
> >>> reported problems with it that will affect these devices/networks tha=
t
> >>> you all are using.  So all we need is a maintainer for this to be abl=
e
> >>> to take reports that we get and fix things up as needed.  I know you
> >>> have that experience, want to come back to kernel development, we've
> >>> missed you :)
> >> That's most kind Greg, thank you, have missed all you cool kids too :)
> >>
> >> More seriously though - I'd be up for doing it, but I think there may =
be
> >> others better placed than I who haven't yet realised we have this conu=
ndrum.
> >> I'm nudging a few folks offline on this front.
> > The main "conundrum" is, is that this protocol completly trusts the
> > hardware to give the kernel the "correct" data.  So if you trust the
> > hardware to work properly, it will be fine, but as the fuzzing tools ar=
e
> > finding, if the data from the hardware modems is a bit out-of-spec,
> > "bad" things can happen.
> >
> > I don't know how well controlled the data is from these devices, if it'=
s
> > just a "pass through" from what they get off the "wire" or if the
> > devices always ensure the protocol packets are sane before passing them
> > off to the kernel.  That's going to be something you all with the
> > hardware is going to have to determine in order to keep this a working
> > system over time.  Especially given that this is a wireless protcol
> > where you "have" to trust the remote end.
>
> Thanks for the thoughts Greg - and ya, I guess on balance I come back to
> being generally skeptical of both hardware and software to Do The Right
> Thing (TM)
>
> So bounds checking and the like seems prudent irrespective of whether
> the kernel is getting the data from real hardware, software modems etc.
>
> I've done some initial digging around that confirms my suspicion that
> this in kernel code remains quite widely used, if somewhat out of view.
> Accordingly I lean then towards working to get these various mitigations
> in place with some revised patches etc. as needed and into the main tree.
>
> Once this done I think that'll give me a good sense of whether I or
> someone else is well positioned to keep the code maintained longer term
> and thus justify it remaining in tree or not.
>
> More to follow once I finish remembering this kernel thing!
>
> Cheers,
> Hugh
>
>
>
>


--=20
Thanks,
Chris Maness

