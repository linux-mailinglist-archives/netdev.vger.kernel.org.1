Return-Path: <netdev+bounces-273995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CwiBmXhzGm0XAYAu9opvQ
	(envelope-from <netdev+bounces-273995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:12:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64092377555
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1959630D6CFC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02943CE4BB;
	Wed,  1 Apr 2026 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eye2wSn4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1C3CB2EF
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034179; cv=pass; b=rsTSDJEPpv8lrMe5xcTjoMBVW+c5I/1TrwGHi0YjpTHj1pZ0DmIx1uiWNJ+w8+9XgWyqYWCEEnxmtzPpqCyLBEZTDdCBSF8YLTJPTkIBjx80c1E33fwGBj6EcbZk5K0enGyyPTSKV0Mden1AXRkxCvYj81d8Ep/x0nXx5sMfpmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034179; c=relaxed/simple;
	bh=rYV0CXfVwJOUE0uyrz5GTmPAMvB3X6YwYjQMQQpTdXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNOsSkLSAXBRntT28nUa4mMF5yOkthCsHVRsDJ8v+BA3a8fiq7g0YQySWGF6cOYWQ+YQFW/Q9z0g5LSb1c07Nzd51sPX/L8mAtMAGML9Lcyao5yE43VeJZQNFGiBQf22V8e/X+yCNRscPx0akpKAbsXeLtEPGe9gyMyypnKwiRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eye2wSn4; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b4001af28so69437581cf.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 02:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034174; cv=none;
        d=google.com; s=arc-20240605;
        b=eT4iPCjY39naeB+J4X6La4USmnbbJcedgk7BjdhZYKFQtZasQl/ti3GP9bnC6cCsAw
         KB3COqgBxzqecjROB6DWLE3hoOYDJTR8nyapCXQQoiaRiLxbccEXtzioJsGvm3bLpDPb
         UOcoa9q22fnld9JVK10zZMOn6WjbEdyM4diyVADrMWEG5peg5xTMzT7LX/nzDJ8Ym2j0
         TvS3oEtJ+wfjZmXdvCWnB7ueP2Bq4oQFSfckDDZG5B+/nFTSoFwSScBEzLj+qpsKf8XO
         3DCh2mUXblvVEIloOnAXUDnZqsVd5fc283RndcgB84dKkdI4DKCGwsuRmyh2P7xI86oV
         /uGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rYV0CXfVwJOUE0uyrz5GTmPAMvB3X6YwYjQMQQpTdXY=;
        fh=4XHTyKcx2k+XVGM6blOw2ELnlXnkLmIkYOzwOLux9Pg=;
        b=jY5z67+30Z62NNQKmMf/nikB97VPVLG51eXWrLFEDVGQAV6BPv9pJUlWwOAwpmuQVQ
         CJg3nNC/kcO/CurGlM90HwgYX0jllt02OB0emLWlewoHpOzBlhezwg7TOISgKtKI0T96
         p/IIlgB1hqXq2aiGq829OoBJDXcprePq/jxfAJJOxGby0zRc+yACdfB3Joc2BXWypwQV
         El6EQTFGwXZq9pf/JVWRYpoW1V93g8Ef9RTavcsteVrsZPJa5aAEaUHYegdYLy9GSk4x
         H2+jY+YYHuAOdfT3nK9VNdbMvKSeArmrusO9Q1mzhvwR1SfTMFb8DLCbl9LGmxbMWbaK
         OSTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034174; x=1775638974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYV0CXfVwJOUE0uyrz5GTmPAMvB3X6YwYjQMQQpTdXY=;
        b=eye2wSn4MMjgqAT55dLWM/QZhMavGByJFY3DLiKG7qfDU12BQXoJCG2u7KOnNpxgoZ
         ASWX3iwctDNfZ5XZhzwYa0H8lawLei4ZS7VoFvvrcI48P78yOZsSznwsCcAxhpXXUvvi
         c8dfElsMUU11peslpe3erFo5JaapzcONpgdP40UnCVQcgOi5ids2Xv2pVU7ITM3ejXGa
         iPrhW6rqpKg4Xo+kCXmMIVOISDFSMfXEd8hdGsH6AsALZ6yACbHurIIO9oz4U9hbofW0
         7EhwNW3ats3LwxcNis3grY7AXJBRZBKLdoZUNDkHO0nbs5B9EUdhw5sDqaRTSBz4lOHJ
         yB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034174; x=1775638974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rYV0CXfVwJOUE0uyrz5GTmPAMvB3X6YwYjQMQQpTdXY=;
        b=M12mkPF4Q37vBIyjLt2zHxwJmJlOKpUW3OZJi7EfYssp8laWFLxr7FvkIMqaNF7cfI
         wxeaBrID9PR0+UWKjhS+uTxHiT1D0rywL63xInRjVBIsCHUAB5cQ2Gxj5d8ZwD9k3O/+
         THyUSpNKi4eKO+JIiIbTn6d9LPAGZMMZ2CV197+Jb7REPyeHgy8KsCAnW+qf9FNRVL/b
         izKX5oGxki1+hmAUX2O8gQj9jZxZ3Sj3R9H3sm5v+INEVA78r9QuZZyi1XJ6GmcfgXp1
         BLah/WMBmrOrYgPN1Z8eZ4CxaIwb4aXjbYa4NKmID9MDie3RKAKXPVJKuucq31diNntP
         EXgA==
X-Forwarded-Encrypted: i=1; AJvYcCXGYVdVy1ZnmJ4zym0yclrD9gT0OFAMtl7pT8437Dz6AC5QTWJFHhdPmYyk/6Ar9L/OqwwA5hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyW3x+lzR/VpIHJbJzj7DoELXYpuA2EHnSV2S7SauTAdnoHs6S
	8cScuYFldng2zSZ0W0EkkBX6CUiWrg1e/vNcAK9h1Ib0oNT5TWjM4FjBH6XjaIskKMSiuZlelPl
	gNaPDPFssuYxa2l4YNZSJq1rH2w6xARI7cAbomWkz
X-Gm-Gg: ATEYQzwKUvqKDQe/5dpgsqEhXNCv5MkndPlkMrWm/S0N59bdPiRLnP2DhVbEEHQ0Pjm
	NKHsfl4irH0XtnTHUfC5Z91akuSCj0muvnuEKAqS6gNYT1rnZbsVErf4U3U3QebLX6AN4aYo3Rs
	6ggaBSTk7LFSNGqngJfVXED5w+bi+RkKYeJjqza8Y53jjwW106DnfHcqX1N3Nc+N/OAJ7O7nT8F
	QQ4EdQutsHcN0F65isiU0CeU0d2ihQjpX4eVToM+g+I6vAGD3SedIN1G/iaeWktKJPH0P+TFhJo
	ye8lRw==
X-Received: by 2002:a05:622a:191d:b0:509:4410:4492 with SMTP id
 d75a77b69052e-50d3bbb1df6mr39068351cf.22.1775034173595; Wed, 01 Apr 2026
 02:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774855883.git.zcliangcn@gmail.com> <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
 <CANn89iJ+pDwKy0kKKG8PrSWMXEStgsMP9YGLxwvjcmMJP1PwrA@mail.gmail.com>
 <4631f54a-bcc8-454b-9355-15a21f9e1e21@gmail.com> <CANn89i+XGF+GheZDO+aWaw5V18mGu2H4OWsCpfs7HriGvCsCRA@mail.gmail.com>
 <7c26a74d-90c5-4520-a10a-22f06e098b86@gmail.com>
In-Reply-To: <7c26a74d-90c5-4520-a10a-22f06e098b86@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:02:42 -0700
X-Gm-Features: AQROBzDTQhW42qjIFrrECSv5jTqnQV3MhppjPTji3DnV5lNg7DTdtjyH8voyb6k
Message-ID: <CANn89i+pAk4A0E1Vnv=HfZ+4qQ872vzzJ8wHH80P29hyQNrzVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: ipv6: flowlabel: defer exclusive option free
 until RCU teardown
To: Yuan Tan <yuantan098@gmail.com>
Cc: kuniyu@google.com, Ren Wei <n05ec@lzu.edu.cn>, security@kernel.org, 
	netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, afaerber@suse.de, 
	mani@kernel.org, yoshfuji@linux-ipv6.org, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, enjou1224z@gmail.com, 
	zcliangcn@gmail.com, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[google.com,lzu.edu.cn,kernel.org,vger.kernel.org,davemloft.net,redhat.com,suse.de,linux-ipv6.org,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.970];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,get_maintainer.pl:url]
X-Rspamd-Queue-Id: 64092377555
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 12:05=E2=80=AFAM Yuan Tan <yuantan098@gmail.com> wro=
te:
>
>
> On 3/31/2026 6:05 PM, Eric Dumazet wrote:
> > On Tue, Mar 31, 2026 at 5:41=E2=80=AFPM Yuan Tan <yuantan098@gmail.com>=
 wrote:
> >>
> >> On 3/31/2026 1:52 AM, Eric Dumazet wrote:
> >>> On Tue, Mar 31, 2026 at 1:34=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wr=
ote:
> >>>> From: Zhengchuan Liang <zcliangcn@gmail.com>
> >>>>
> >>>> `ip6fl_seq_show()` walks the global flowlabel hash under the seq-fil=
e
> >>>> RCU read-side lock and prints `fl->opt->opt_nflen` when an option bl=
ock
> >>>> is present.
> >>> Some points :
> >>>
> >>> Please do not CC security@ if you submit a public patch, there is
> >>> absolutely no reason for it.
> >>>
> >>> Please do not resend the same version within 24 hours; this creates n=
oise.
> >>> Your patch wasn't lost; we have many patch reviews and similar bugs t=
o address.
> >>>
> >>> Thank you.
> >> We sincerely apologize for the confusion caused by our previous email.=
 Previously, when we sent reports and patches to the security list, we were=
 advised that patches should be submitted to netdev@ for public review. To =
follow this, we are now sending the full vulnerability details to security@=
 while additionally submitting the patches to netdev@. Please let us know i=
f this is the correct way to handle such cases.
> > When/If an issue and a patch is sent publicly, security@ involvement
> > ends. netdev maintainers take over.
> >
> > Thus there is no point CCing this list of security officers, which is
> > currently flooded by many LLM-based findings.
> > Please help them by keeping their inbox a bit saner.
> We would like to standardize our workflow to ensure it aligns with
> community expectations. We've checked the maillist and netdev docs for
> these details but found no clear answers. Could you please clarify which =
of
> the following is preferred?
>
> Option 1: Send the security report to security@ and submit the patches
> directly to the subsystem mailing list without CC security@.
>
> Option 2: Send both the report and the patches to security@ for an initia=
l
> review. After approval, re-send the patches to the subsystem mailing list=
.
>
> For Option 1, I have hread that there are bots on the public lists to hel=
p
> with the review. The Option 2 feels slightly redundant and might cause
> confusion. We are open to any other workflow that the community prefers.
>
> We are wondering if it's better to send the PoC and detailed analysis
> directly to netdev@ for bugs we deem to have low exploitability, which
> would help minimize the burden on the security@ team. However, these bugs
> are still triggerable by unprivileged users, we are concerned that postin=
g
> full PoC to a public mailing list might be inappropriate or risky.
> >> Regarding the CC list, could you provide further guidance on who we sh=
ould include? Currently, we are CCing everyone suggested by get_maintainer.=
pl because we previously received feedback about missing relevant maintaine=
rs. For public mailing lists, we should only including netdev@. Should we b=
e more selective?
> > Yes, folks that are interesting into following netdev changes are
> > subscribed to netdev@ mailing list.
> >
> > Unless a patch touches non-networking parts and requires approval from
> > other branch maintainers, there is no
> > point CCing other lists.
> Thank you for your advice. We will no longer CC individual maintainers on
> patches sent to netdev.
>
> Regarding security reports, however, we had previously been advised to CC
> more people to avoid manual forwarding.
>
> To be honest, we are a bit confused by the conflicting guidance we've
> received. We sincerely want to establish a standardized process for our
> future contributions to make everyone happy.
>
> >> Finally, regarding our tags, our team has a clear division of labor=E2=
=80=94some focus on finding vulnerabilities, others on fixing them, followe=
d by an internal review and testing before a dedicated member handles commu=
nity outreach.
> >>
> > You included 8 tags, this seems a bit too much for such a small patch.
> CC Greg here, as he knows a bit about our team's background.
>
> Our team has developed a tool that found hundreds of non-root bugs with
> PoCs. We want to ensure these are fixed properly and quickly rather than
> dumping reports onto the mailing list and hoping for others to find the
> time to fix. So we have organized a group of promising students. As some =
of
> them are new to kernel development, we have been providing hands-on
> mentorship to guide them through the process.
>
> Regarding credit attribution: Yuan, Yifan, Jufei, and Xin were all
> instrumental in the tool's design and implementation, so we listed them
> with Reported-by tags. Xin provided the funding and led the fixing team, =
so
> we included a Suggested-by tag for him (though this could be changed to
> Reported-by as well). Then after including the patch author, this natural=
ly
> results in five tags.
>
>
> As for using a designated sender to submit these patches, it's because
> using Gmail with git send-email is difficult in China and the university
> email servers prohibit the use of the SMTP protocol. Therefore, we had to
> apply for a separate account specifically with SMTP permissions to submit
> patches.
>
> We fully respect the maintainers' discretion in this matter. If the curre=
nt
> tags are still considered unacceptable, we will make the necessary intern=
al
> adjustments.

Again, no need for all this, I already gave a 'Reviewed-by', I was not
saying it was unaccptable.

Oh well.

