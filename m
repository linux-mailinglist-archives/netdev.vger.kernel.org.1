Return-Path: <netdev+bounces-163920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65152A2C06F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0A73AA8F8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399E1A76AE;
	Fri,  7 Feb 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fyonaDtV"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA680BFF;
	Fri,  7 Feb 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923585; cv=none; b=ZzSlTb+CNshlSWJIv4mFXWNMph0PLDxNNKT3WWKLAvzCG2lqVMq6yBMyHPSkcu369wEAGpExjsqJS1i8W8Ya2mCrVPyhgV/Fk7vYEdTKzhi45NDR5QDrX6yGEYsjiQ/eRYskE78e31gg8hLfV9Hxz3+gfevdY49IXV11CrVSOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923585; c=relaxed/simple;
	bh=mPMFTHR4rBA+H6dCcJyNw7a2lNwmdYXMtTaGdeo4Dno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ubab3sLPnmRoT/TQFpqm9y0lcHOrYlFAogF+j2F4JoJuDbuqURPPk5kGNfbx76Q2Tv0BIjHLZg+IjxW2BxGTAzI2t2Xcab+wuFNaL/wktJOG5VS12Q+CPEF+yZDwZ/i8ml8ScIfL4uPdGDAMuONBxbAL/lg/lmaezciTkUFTM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fyonaDtV; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A90014320C;
	Fri,  7 Feb 2025 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738923576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SMfhxqX1urprU+ZzaHkHZbbWVTlqJ3h4oTfkgVeU/g=;
	b=fyonaDtVpwCNdRj3zDEoj1XxT0seswkdK6PMTLH0BqYGKcyyGt6W9Gx4HPKTFKsSey0lHn
	XsYISdmWpOJfdAnQ4eA9xQKvi25oFSYTljMkEVmF11/Mrs1QquexBb/wuAqbbxXxVXht2y
	gpy24acboli5tKIwEkxubaot/nMDnhOWJSHbd1VUKbiLkSVIdRvaUwg2o+utXl5mPbA0Se
	l9LwTes51GK2w8B0eXIVp2r2Jw7yclz4CZk00KZBrKNvbz2gUiZurgnZKFBrQYJVzTWRwI
	t5j8Hkl7Cj+uSZs4OobaPSfRETg13Xz1J7yZ0l48Ioh/CONrzYBOop9jXddA0w==
Date: Fri, 7 Feb 2025 11:19:32 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+86a8ab09a0f655f1ff19@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] general protection fault in
 generic_hwtstamp_ioctl_lower (2)
Message-ID: <20250207111932.55e9d377@kmaincent-XPS-13-7390>
In-Reply-To: <20250206175618.6ac4182d@kernel.org>
References: <67a230a8.050a0220.d7c5a.00ba.GAE@google.com>
	<20250206175618.6ac4182d@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheffgfevteehfeektedvheduudelffdtkeelleeuledtkeetveffhfdtgedvleetnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeelhegrvgemlehftddtmeduvdeffhemfheffeejmedusgejheemkeekhegrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemleehrggvmeelfhdttdemuddvfehfmehffeefjeemudgsjeehmeekkeehrgdphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshihiigsohhtodekiegrkegrsgdtlegrtdhfieehhehfudhffhduleesshihiihkr
 ghllhgvrhdrrghpphhsphhothhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 6 Feb 2025 17:56:18 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 04 Feb 2025 07:22:16 -0800 syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git:=
//g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13324b24580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D98d83cc1742=
b7377
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D86a8ab09a0f65=
5f1ff19
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for
> > Debian) 2.40 syz repro:
> > https://syzkaller.appspot.com/x/repro.syz?x=3D17324b24580000 C reproduc=
er:
> > https://syzkaller.appspot.com/x/repro.c?x=3D161595f8580000 =20
>=20
> Hi Kory!
>=20
> Looks like syzbot wasn't able to bisect and didn't CC you.
> Please take a look, looks like struct kernel_hwtstamp_config
> gets into the ioctl paths.

Hello Jakub,

Thanks for transferring it to me. I will look at it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

