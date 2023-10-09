Return-Path: <netdev+bounces-39389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE307BEF5F
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 01:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7957C281823
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 23:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481147375;
	Mon,  9 Oct 2023 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skym.fi header.i=@skym.fi header.b="MD6s4unO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSSQ1nTk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749A47363
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 23:51:18 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A7CA7
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 16:51:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 25B205C02C5;
	Mon,  9 Oct 2023 19:51:13 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Mon, 09 Oct 2023 19:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skym.fi; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1696895473; x=1696981873; bh=QPhhfuTn8dWrXfMXBvKQgAu3hMOz6o7Ef/K
	oQCq+2yo=; b=MD6s4unO6LnBJXdQJYR02PWZztYPE1l/bzv8ccaP4+MwrK1jcC6
	CZ0Qe4xC0fXvBBLYsrPVF/MMLv2/hwjM7w84FF3t3p2CJQOcWBk2maN8C67WW6RD
	8cbZOgtthEVzkk20ia36KITebzHuI8KS1f3xVLpn7loBKN1wfmpJh67mTymywfCa
	5slTDhH5H7kWAF/TLr/c+iuvszXcEPXRrjuUdLHx6Dt37sB+xtx2DsxbJTx3tbxi
	lcDUrD/oZ7f1K/Nrwc+RLjZtTZHrkTTclgJk7rVTu9oByz02LWlUoKBUwYamNLrz
	zaLWR5bfTDH3t+Kc0OAbs5N8jqhA48mcXSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1696895473; x=1696981873; bh=QPhhfuTn8dWrXfMXBvKQgAu3hMOz6o7Ef/K
	oQCq+2yo=; b=RSSQ1nTkTFagVWv0BLqyL+KovEh17F8/IhQsARRMLNjAKkLQKAt
	abSc3kSLha9Z2RmYZzz5/a+vvBqukWHVa+yvWgBHWTkQrnltp6qww+9hv5q8RSRq
	9rkbIZoCfjNGtgWLViE4mq+/j8qPM4LWG6g24lJEwGQ1mjurce7Aq9rvjogwOBHv
	y3tvfNPn9V96hth4iQ4fn7AQjWbev5TnecP4y8MIaFNz5ZJDSPMhL9EDUYFNcyqb
	x4PjV/YdfkUuM3bh8iWqqlDw/muupBabRgoONKi4Hlh0lsR2l9JwlvoBwYG2tg9p
	tXv15E6TS87TLt4ZjXEggamZvKcapa+oV9Q==
X-ME-Sender: <xms:8JEkZRIaG_G5zBq-Ig6uE9rr00acr15yd3LPMa3MJlw8DI76h_PTgQ>
    <xme:8JEkZdJhhO4aokOo_kYAqkgcx4yDQlV4EEpYzEZsq_IDW1_4n6eM68B50TVTngyN5
    umgbo2MEYDHvM2nYGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheeggddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpefukhih
    lhgvrhcuofomnhhthihsrggrrhhiuceoshhmodhlihhsthhssehskhihmhdrfhhiqeenuc
    ggtffrrghtthgvrhhnpeetheegleegveeugeffheeuueekffevvddvtdejffeijeffkefh
    hfeutedtteetgfenucffohhmrghinhepvhihohhsrdhiohenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsmhdolhhishhtshesshhkhihmrdhf
    ih
X-ME-Proxy: <xmx:8JEkZZuqOL_3mbwZU1w-5NXBTW_hXThv8wVRUL_mX7XQS7gdjz4Zqw>
    <xmx:8JEkZSZSL0pU9teE9G_pQ8YkNOWxLFc8r5lOxLCTrFPwlPGvwyaJdg>
    <xmx:8JEkZYbiPwW6HtgHBV5J8PDWKV4JVtUeR97khRi4ygG3KbKuMi-NZg>
    <xmx:8ZEkZRBg-O1rZp-1skYspAHEH0O74jrp-seGDBjAc4DtRBXfT8fGkQ>
Feedback-ID: id05146f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B0A1D15A0091; Mon,  9 Oct 2023 19:51:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4330a47e-aa31-4248-9d9d-95c54f74cdd9@app.fastmail.com>
In-Reply-To: <6e48c3ba-8d17-41db-ca8d-0a7881d122c9@intel.com>
References: <ee7f6320-0742-65d4-7411-400d55daebf8@skym.fi>
 <994cebfe-c97a-4e11-8dad-b3c589e9f094@intel.com>
 <c526d946-2779-434b-b8ec-423a48f71e36@skym.fi>
 <6e48c3ba-8d17-41db-ca8d-0a7881d122c9@intel.com>
Date: Tue, 10 Oct 2023 02:50:14 +0300
From: =?UTF-8?Q?Skyler_M=C3=A4ntysaari?= <sm+lists@skym.fi>
To: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] The difference between linux kernel driver and FreeBSD's
 with Intel X533
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On Mon, Oct 9, 2023, at 18:33, Jesse Brandeburg wrote:
> On 10/4/2023 10:08 AM, Skyler M=C3=A4ntysaari wrote:
>>>> Hi there,
>>>>
>>>> It seems that for reasons unknown to me, my Intel X533 based 10G SF=
P+
>>>> doesn't want to work with kernel 6.1.55 in VyOS 1.4 nor Debian 12 b=
ut
>>>> it does in OPNsense which is based on FreeBSD 13.2.
>>>>
>>>> How would I go about debugging this properly? Both sides see light,
>>>> but no link unless I'm using FreeBSD.
>> https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/12253=
/11?u=3Dsamip537
>
> Hi Skyler,
>
> Response from Intel team:
>
> In the ethtool -m output pasted I see TX and RX optical power is fine.
> Could you request fault status on both sides? Just want to check if li=
nk
> is down because we are at local-fault or link partner is at local-faul=
t.
>
> rmmod ixgbe
> modprobe ixgbe
> ethtool -S eth0 | grep fault
>
> Since it is 10G, if our side TX is ON (power level says it is) then we
> should expect link partner RX to be locked so cannot be at Local Fault.
>
> Skyler, please gather that ethtool -S data for us.
>
> Jesse
>
>
>
>=20

Hi Jesse,

As the other side of the link is an Juniper, I'm not quite sure how I wo=
uld gather the same data from it as it doesn't have ethtool?

I have also somewhat given up hope on it working on VyOS and instead I a=
m using OPNsense for the moment but I still have VyOS installed as well.

Skyler




