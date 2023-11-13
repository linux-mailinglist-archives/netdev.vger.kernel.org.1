Return-Path: <netdev+bounces-47341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0B47E9C6F
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E0F1F20C95
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 12:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F81D69C;
	Mon, 13 Nov 2023 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLGpMzIC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733821D68D
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 12:52:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA8ED7E
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 04:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699879959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnUtca0D5C0XPHxlPtQvKGqukhORv7SHWA8KedKey5k=;
	b=iLGpMzICENwYI4QiL9G6rfUDFKUX3OYAM2jXcuFFcAvVGZg+HbI7bwuzhbEXRoPRvUHO6r
	ZrxzCDuhE9x76trwJGfvA6ebfCANIMBwQNxSKapxH+a8dLIOEoVUxnkNBSkNhxmfI44e/1
	6Lug10tGb+W5SGkTh4mrhMb/EcHExzM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-q5kekHmROvKhva2VXUgJLA-1; Mon, 13 Nov 2023 07:52:37 -0500
X-MC-Unique: q5kekHmROvKhva2VXUgJLA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9e5e190458dso345461566b.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 04:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699879956; x=1700484756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnUtca0D5C0XPHxlPtQvKGqukhORv7SHWA8KedKey5k=;
        b=ZqZqSvkeCvkKZVJrQeWoDl4sEOmNTADO1aHBvSZ/FHZsC4k6wbuy3Tc2+FIItyfJdw
         HPupVoMWgjDFYiwF6qJOm60QCCkwwDkQR/Y9O2vvhKCox9R9Am6l9ylVzOD3+4hhpIR7
         NMEYX++BZ3IAqzcxWwS0xEovi022+kg2Ilx5EfSC0IKPZtzawsoPklnsJFpMLhAqjWZt
         hFtUY+TFmxfx0EuzfmzNN7VtBF5Aq13ooFwcMQtUfHdeZi1utvPz0WjiXQOFCtLz1EtL
         wyxrkjppr3loO1oWSdiqfSlhhIJBzeyR3penn7VGAY7slMeNbgGbxDOBcDRJbQEhQr+7
         bk5g==
X-Gm-Message-State: AOJu0YzxFFPKui0yD4PLvbYRwtGO4i3i6j8thEfMBDivBa6jfvoeKxyV
	yD8mh2vE3iOnRWu99wgRRVRwD7YSUqCdpXpt2vjo+1hjCBLbZ3/8H3NFV2Yd6aL+qxSIqR8T+Zt
	YI9lI1H/1Hg+JuRSgo/GJMohI9kOd29bv
X-Received: by 2002:a17:907:c913:b0:9b2:b37d:17ff with SMTP id ui19-20020a170907c91300b009b2b37d17ffmr8036008ejc.19.1699879956612;
        Mon, 13 Nov 2023 04:52:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8wRqBXyTcz5o2Yg/BKUm2neXUHVSvWYk4dKDU3CaR+5fQtk8GT71yB/NlVbBR/NK8YSBtyNON3vl8KmEzKMI=
X-Received: by 2002:a17:907:c913:b0:9b2:b37d:17ff with SMTP id
 ui19-20020a170907c91300b009b2b37d17ffmr8035986ejc.19.1699879956317; Mon, 13
 Nov 2023 04:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927181214.129346-1-miquel.raynal@bootlin.com>
In-Reply-To: <20230927181214.129346-1-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 13 Nov 2023 07:52:25 -0500
Message-ID: <CAK-6q+i=biD0pgWsY002PpY_bp3bM56=PdMgqdo5x4bH+JsznA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v5 00/11] ieee802154: Associations between devices
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, 
	Romuald Despres <romuald.despres@qorvo.com>, Frederic Blain <frederic.blain@qorvo.com>, 
	Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem Imberton <guilhem.imberton@qorvo.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 27, 2023 at 2:12=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hello,
>
> Now that we can discover our peer coordinators or make ourselves
> dynamically discoverable, we may use the information about surrounding
> devices to create PANs dynamically. This involves of course:
> * Requesting an association to a coordinator, waiting for the response
> * Sending a disassociation notification to a coordinator
> * Receiving an association request when we are coordinator, answering
>   the request (for now all devices are accepted up to a limit, to be
>   refined)
> * Sending a disassociation notification to a child
> * Users may request the list of associated devices (the parent and the
>   children).
>
> Here are a few example of userspace calls that can be made:
> iwpan dev <dev> associate pan_id 2 coord $COORD
> iwpan dev <dev> list_associations
> iwpan dev <dev> disassociate ext_addr $COORD
>
> I used a small using hwsim to scan for a coordinator, associate with
> it, look at the associations on both sides, disassociate from it and
> check the associations again:
> ./assoc-demo
> *** Scan ***
> PAN 0x0002 (on wpan1)
>         coordinator 0x060f3b35169a498f
>         page 0
>         channel 13
>         preamble code 0
>         mean prf 0
>         superframe spec. 0xcf11
>         LQI ff
> *** End of scan ***
> Associating wpan1 with coord0 0x060f3b35169a498f...
> Dumping coord0 assoc:
> child : 0x0b6f / 0xba7633ae47ccfb21
> Dumping wpan1 assoc:
> parent: 0xffff / 0x060f3b35169a498f
> Disassociating from wpan1
> Dumping coord0 assoc:
> Dumping wpan1 assoc:
>
> I could also successfully interact with a smaller device running Zephir,
> using its command line interface to associate and then disassociate from
> the Linux coordinator.
>
> Thanks!
> Miqu=C3=A8l
>
> Changes in v5:
> * Fixed (again) the helper supposed to check whether a device requesting
>   association/disassociation is already (or not) in our PAN. We don't
>   nee to check short addresses there.
> * Changed the name of the helper a second time to make it more relevant
>   and understandable:
>   cfg802154_device_in_pan() -> cfg802154_pan_device_is_matching()
> * Fixed a kernel test robot report where we would use an int instead of
>   a __le16. Solved that by using cpu_to_le16 like in the other places
>   where we use definitions as arguments.
>
> Changes in v4:
> * Ensured any disassociation would only be processed if the destination
>   pan ID matches ours.
> * Association requests should be made using extended addressing, it's
>   the specification, so ensure this is true. Doing so helps reducing the
>   checks down the road.
> * Updated a copyright from 2021 to 2023.
> * Improved the comment for cfg802154_device_in_pan() and only accept
>   extended addressing when using this internal function because there is
>   no point in checking short addresses here.
> * Move nl802154_prepare_wpan_dev_dump() and
>   nl802154_finish_wpan_dev_dump() outside of a
>   CONFIG_IEEE802154_NL802154_EXPERIMENTAL #ifdef bloc as now used in
>   regular code (not only experimental).
> * Added a missing return value in the kernel doc of
>   cfg802154_device_is_associated().
>
> Changes in v3:
> * Clarify a helper which compares if two devices seem to be identical by
>   adding two comments. This is a static function that is only used by
>   the PAN management core to operate or not an
>   association/disassociation request. In this helper, a new check is
>   introduced to be sure we compare fields which have been populated.
> * Dropped the "association_generation" counter and all its uses along
>   the code. I tried to mimic some other counter but I agree it is not
>   super useful and could be dropped anyway.
> * Dropped a faulty sequence number hardcoded to 10. This had no impact
>   because a few lines later the same entry was set to a valid value.
>
> Changes in v2:
> * Drop the misleading IEEE802154_ADDR_LONG_BROADCAST definition and its
>   only use which was useless anyway.
> * Clarified how devices are defined when the user requests to associate
>   with a coordinator: for now only the extended address of the
>   coordinator is relevant so this is the only address we care about.
> * Drop a useless NULL check before a kfree() call.
> * Add a check when allocating a child short address: it must be
>   different than ours.
> * Rebased on top of v6.5.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks for working on this!

- Alex


