Return-Path: <netdev+bounces-191987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88A6ABE1A9
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121661B64B5F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AAC263F44;
	Tue, 20 May 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="THSqRSbD"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E77258CF7
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761313; cv=none; b=bm5ZOODaVsiYzqRKT9dibub70sODiKcYrp6aLFB25X/nAf+Y4sogpyOKI02x5/obxBPR0kELv5KsYO+V1EW6U3i2rQvaY/SDH/6pk4jckPHWI5QHJlCyCzcCKjcju3TaHvbPkYPYHQvj3LC8TcO89TXl7AQTledpkFu3lr3odOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761313; c=relaxed/simple;
	bh=MP7ZBieL2esCHsyJ17NmFPXmvyb3v+k/qfs9Xo3HS8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcxeHQG762hX7eS4xUbj9uFE/txvTbd4IxU6yXGTOa7atbud2KvjL3MGW9W7XhRSYSRFsmtoio7zl+qGFdP26h3HSqirtwsRjuGPx+yZERijYVFChpOuAJvE9dIf/aDemO/TCaAgIdwsadIrUt3OJQpCw+zu3bjEyqtKOi+Xqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=THSqRSbD; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A32F943396;
	Tue, 20 May 2025 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747761309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MP7ZBieL2esCHsyJ17NmFPXmvyb3v+k/qfs9Xo3HS8M=;
	b=THSqRSbDqUaUPpiSsdXGn8OBVcFWVwI15CepmGunDzmrfhT50tv+SiZTCjbvZjmZc0pi4+
	sIX+5EoQPCfFtQT9ZyrlnxS1QThYeCVinhXC7p97oT6eJEfNlXTk9z5LxXwSoousXETvFz
	cLStem0pSDOUIj3R+PWv+x+aQ7hqbZi0bKQrlUenEOr8p1CO6Yq2pvUi4IDoU2EDp9BewJ
	SfYrAqf4l+UZxY2l6AYQUg5OoU0PVTI+rJeU6D1WBTook6Z75UuhOaYq1pMQ08udrTKWhQ
	XHlFMvG5sgEMJnkD0IU0CzvZ72+NfSKIN1hJsZXanu/ELaE1ymEkYIYaitBhsw==
Date: Tue, 20 May 2025 19:15:06 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me,
 jstancek@redhat.com
Subject: Re: [PATCH net-next v2 01/12] tools: ynl-gen: add makefile deps for
 neigh
Message-ID: <20250520191506.145fa105@kmaincent-XPS-13-7390>
In-Reply-To: <20250520161916.413298-2-kuba@kernel.org>
References: <20250520161916.413298-1-kuba@kernel.org>
	<20250520161916.413298-2-kuba@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejkeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfduveekuedtvdeiffduleetvdegteetveetvdelteehhfeuhfegvdeuuedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemkeehkeejmeejuddttdemtgegrgdumegtfhdutdemugehhegsmegukedufhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmegtgegrudemtghfuddtmeguheehsgemugekudhfpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvv
 hesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 20 May 2025 09:19:05 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Kory is reporting build issues after recent additions to YNL
> if the system headers are old.
>=20
> Link: https://lore.kernel.org/20250519164949.597d6e92@kmaincent-XPS-13-73=
90
> Reported-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: 0939a418b3b0 ("tools: ynl: submsg: reverse parse / error reporting=
")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Tested-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

