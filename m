Return-Path: <netdev+bounces-33180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE6A79CE33
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3361C20D59
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FDF1799A;
	Tue, 12 Sep 2023 10:26:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BFC1775E
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:26:58 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1856DE6C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:26:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 619E12000A;
	Tue, 12 Sep 2023 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694514416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k0GogBf+GJNfsaEKvwOAbpyy2BfHHxm9ybOBAoeGqzQ=;
	b=WrYk7xnXYEpOgNgEIKcNlQj8YYF8X6k91/8H/+3a4Jj+vc/ptCn8ERMue9+lMk2+IZadcc
	9pGCtOnVmmmbEcXtIRDznXKCqb9y2Qzlz0lWuWqcXySTcqRlXpZmW1u8YbKuOUFG9EwQbF
	UeUsR2Sf27qltQH8uVdfKuQ4kaOifOtsO/w5pFEu8q2hP4Fr2fECm5A0/9uQsHIOt/yXwg
	XKPW3EgwcomKZgVpP042zZ7p24nkLhUYQeK126H139F2HdPophICizeESj3EGk4PdQeCao
	i2QYjS7pesWu4SL+L7DbJYWFhrCmBPGB1sJ9Nr6ZJYZpgatwDh1GTAGJ9EFs1A==
Date: Tue, 12 Sep 2023 12:26:55 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Jakub Kicinski
 <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: PoE support
Message-ID: <20230912122655.391e2c86@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello,

I am working on the PoE support and I am facing few questioning.
I would like to use the same commands and core as PoDL, but non generic
development raised questions.

The admin_state and admin_control are the same therefore I will use the
ethtool_podl_pse_admin_state enumeration.
The power detection status have few differences, I thought that adding PoE
specific states to ethtool_podl_pse_pw_d_status rather than adding a new
ethtool_pse_pw_d_status enum is the best way to avoid breaking the old API.

I also would like to remove PoDL reference to ethtool but keep
"podl-pse-admin-control" command for old compatibility alongside a new
"pse-admin-control" command.

What do you think? Do you think of a better way?

K=C3=B6ry


