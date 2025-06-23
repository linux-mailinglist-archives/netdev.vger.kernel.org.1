Return-Path: <netdev+bounces-200135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B485CAE353E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 07:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E06716C790
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 05:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BABB1D6DDD;
	Mon, 23 Jun 2025 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CXyjCqPt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WpDl73Yc"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5D1991B6;
	Mon, 23 Jun 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750658252; cv=none; b=NKSORVmWjrMQ+lhwCeCvz13iDK2AtaJlt7wktd9DyAn0XHHFrtblhm0cRUfDzqZ5BCbysK5L0bMqZ5OfGK0MjYgVtwzX5xnpNQ72riAscPqD+kFvReSpMuN6wKzC2wDBr0TVoKgv3IUaytdnqYnjjiXtcQ/0lWHztADBBS8PTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750658252; c=relaxed/simple;
	bh=zslrUw/71JAV7TvJy4yqUFn9U16ApNY7CYiRXUJdlCI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h99cCjcwVO9Nglw58sIujMMWXPyiWUcjWoY3zYbO+35YeSHr7TEq5Lz4iNyQXk1wAq1QTI3PJPBPUVBrEQz7xu2LCn8NlFWAVXYmt7rezDsKMrkpX7wywABWiO1Brt0ljE6mBHKYrTaLgrpqkHfw5erw0LoVc687/dAk61szkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CXyjCqPt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WpDl73Yc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDC591140173;
	Mon, 23 Jun 2025 01:57:28 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 23 Jun 2025 01:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750658248;
	 x=1750744648; bh=IQNxDuMP3QPjXQF2/Ju4i3ejXs1KloFPbPXgsytRE+s=; b=
	CXyjCqPtKCWydABtSzQ5sInbbE9D9tlS4MR7hKK9J1qInZLSPQNN8mUiC/03bAxJ
	msvtUWlzRv1UygjJgAxRDlOhpYoiRCz8IIRDa5EWck1XsXmMCkli8Us7vUyNPDkF
	XB9JBl3ThNjm5vD5BB5RkbCarkedwvNIgm9HnmaN5DNZXfuJOu+iHGaPC0C9u9Ut
	zX2AYCcCKgfnyC+Uu7rAu1EImINOSV6GykrhPX7zbyrXD4qsZxmHvcRDwXqafBS5
	rlfBasBOIt36Edwmuv1Zp4UQ686ES737AG1bEIJv1F+kkrEjIJ1a786sttqNz3ZT
	nYcuTfcOIW8+559mTgo2Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750658248; x=
	1750744648; bh=IQNxDuMP3QPjXQF2/Ju4i3ejXs1KloFPbPXgsytRE+s=; b=W
	pDl73YcyN+TBFCdF0ve7yEs7SSDgkG3FtZFw1tRcovFx1yDfNa10eUiU6etff/5e
	wjG3eWPVyLmsUcuoHFFlYf4leXY1VXmm7Kh0bbm/9e6nRsyupWZPacfdrc2Rzu+V
	qOIn7kOGHf6Mawsukf8v3bEHrQIXqGs4hkzhtW1aGeDuKzQxjlWeFnxYWYGapdna
	xwfpeVlVNZBxINB/sEmC+hhigYCC3+RVuV+6mz5k+qNkwSAk5KWOx0OhrqWK7A9F
	XISz4ygPZyxsUheBmr/c8skJKyEC1eSh0SVVnxRBhAoS1BWq8acw1847fXw7PhaY
	Rq3X58MZEi4tpRTXCgsqw==
X-ME-Sender: <xms:x-xYaNoWVncNTjpWtBhozJiYyfN8ql1ea_BcyvjV55Hr5fMNK6TMVA>
    <xme:x-xYaPqyHY0_pg67VdpPECG3Dyn6vB67SSzwh7rUge4YyqXjeUIJ90E8-MgDEKc2P
    4ZLa83TAbLzxbbRG8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduiedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    hnihgtkhdruggvshgruhhlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjuhhsth
    hinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmohhrsghosehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehlrghnhhgroheshhhurgifvghirdgtohhmpdhrtg
    hpthhtohepshgrlhhilhdrmhgvhhhtrgeshhhurgifvghirdgtohhmpdhrtghpthhtohep
    shhhrghojhhijhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepshhhvghnjhhirg
    hnudehsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:x-xYaKMoSoZwakMHAZZEMeFpc4gowlBQJVzVPLkUhkazdvuXf9ZJ-w>
    <xmx:x-xYaI4rPeNeOn5HlFmOudplAV84e4iAWhrmGqv7S42JXaUeGNA_DA>
    <xmx:x-xYaM7jWD0enxI7OwRUnJVS9AKgYecwF41SlP8Xz9-HTJm-ao_BtA>
    <xmx:x-xYaAivUiIvj3brciSTFM7iAjwpN170dN8QOqjBQN8eeuwlxkBVoA>
    <xmx:yOxYaKlFdw3j-zWBTNeRYtVIRJ9SdgZu4z3cT6QShSi1AJz_HYCxG3mo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CBEA4700062; Mon, 23 Jun 2025 01:57:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0988381ff57d4bb7
Date: Mon, 23 Jun 2025 07:56:06 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jijie Shao" <shaojijie@huawei.com>, "Jakub Kicinski" <kuba@kernel.org>
Cc: "Jian Shen" <shenjian15@huawei.com>,
 "Salil Mehta" <salil.mehta@huawei.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Hao Lan" <lanhao@huawei.com>, "Guangwei Zhang" <zhangwangwei6@huawei.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <13cf4327-f04f-455e-9a3a-1c74b22f42d0@app.fastmail.com>
In-Reply-To: <cb286135-466f-40b2-aaa5-a2b336d3a87c@huawei.com>
References: <20250610092113.2639248-1-arnd@kernel.org>
 <41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
 <a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
 <34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
 <20250612083309.7402a42e@kernel.org>
 <02b6bd18-6178-420b-90ab-54308c7504f7@huawei.com>
 <cb286135-466f-40b2-aaa5-a2b336d3a87c@huawei.com>
Subject: Re: [PATCH] hns3: work around stack size warning
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025, at 05:19, Jijie Shao wrote:
>> on 2025/6/12 23:33, Jakub Kicinski wrote:
>>
>
> *Hi Jakub, Arnd We have changed the impleament as your suggestion. Wou=
ld=20
> you please help check it ? If it's OK, we will rewrite the rest parts =
of=20
> our debugfs code. Thanks! *

The conversion to seq_file looks good to me, this does address the
stack usage problems I was observing.
Thanks for cleaning this up!

> -    sprintf(result[j++], "%u", index);
> -    sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
> -        HNS3_RING_TX_RING_BD_NUM_REG));
> +    seq_printf(s, "%-4u%6s", index, " ");
> +    seq_printf(s, "%-5u%3s",
> +           readl_relaxed(base + HNS3_RING_TX_RING_BD_NUM_REG), " ");

I'm not sure I understand the format string changes here, I did
not think they were necessary.

Are you doing this to keep the output the same as before, or are
you reformatting the contents for readability?

> +static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32=20
> cmd)
> +{
> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D &handle->pdev->dev;
> +=C2=A0=C2=A0=C2=A0 struct dentry *entry_dir;
> +=C2=A0=C2=A0=C2=A0 read_func func =3D NULL;
> +
> +=C2=A0=C2=A0=C2=A0 switch (hns3_dbg_cmd[cmd].cmd) {
> +=C2=A0=C2=A0=C2=A0 case HNAE3_DBG_CMD_TX_QUEUE_INFO:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 func =3D hns3_dbg_tx_queue_info;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 default:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 entry_dir =3D hns3_dbg_dentry[hns3_dbg_cmd[cmd].de=
ntry].dentry;
> +=C2=A0=C2=A0=C2=A0 debugfs_create_devm_seqfile(dev, hns3_dbg_cmd[cmd]=
.name, entry_dir,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 func);
> +
> +=C2=A0=C2=A0=C2=A0 return 0;

This will work fine as well, but I think you can do slightly better
by having your own file_operations with a read function based
on single_open() and your current hns3_dbg_read_cmd().

I don't think you gain anything from using debugfs_create_devm_seqfile()
since you use debugfs_remove_recursive() for cleaning it up anyway.

     Arnd

