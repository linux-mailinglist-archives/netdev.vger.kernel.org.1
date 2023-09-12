Return-Path: <netdev+bounces-33244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED779D203
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB19A1C20B71
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92702134AB;
	Tue, 12 Sep 2023 13:25:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865498C18
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:25:17 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEA210D0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:25:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B6BA1BF207;
	Tue, 12 Sep 2023 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694525114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72rrzv8GmaB1Od6ZXjmlCOLr04RauyKSbRBQhcAJ8ds=;
	b=ZW+IKZFfJXOnyHuKK8JDVa+YeqvFCkRl0au3GzHKKN1ukgZM1AhH5HRY03pohmD8PB3ZFR
	cgBIzg9m7Oy0jFeQwqlJKOX4wuwN4IIR77CT2yNfNXNcvL5nad9aVEPiW9Xn7NPQsDXmuX
	ETusjrfAvfan+DJK14H5I6upoyimV5nPzJYuUYBffS4Lcf+2NmmJnNnZM7MvdR5UhdCHqk
	jPOTTruT5yq75uAUfaGvyloqWBXSGzgtybOkSSMMBXVqRW5fYil2fTbtUqcVrLfIsgX/Cn
	s6ODPWKEaE75qHygn/obpG3YDbwA1D+GKPsRMhKWaGRNuCS9/a+cZPQ5WoCa9A==
Date: Tue, 12 Sep 2023 15:25:13 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE support
Message-ID: <20230912152513.6dba998a@kmaincent-XPS-13-7390>
In-Reply-To: <20230912110637.GI780075@pengutronix.de>
References: <20230912122655.391e2c86@kmaincent-XPS-13-7390>
	<20230912110637.GI780075@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 12 Sep 2023 13:06:37 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> > What do you think? Do you think of a better way?  
> 
> By defining UAPI for PoDL/PoE I decided to follow IEEE 802.3
> specification as close as possible for following reasons:
> - we should be backwards and forwards compatible. IEEE 802.3 is always
>   extended, some existing objects and name spaces can be extended
>   withing the specification. If we will merge some of them, it may get
>   challenging to make it properly again.
> - PoDL and PoE have separate attributes and actions withing the
> specification. 
> - If we follow the spec, it is easier to understand for all who need to
>   implement or extend related software
> - I can imagine some industrial device implementing PoDL/PoE on same
>   port. We should be able to see what is actually active.
> 
> IMO, it is better not to mix PoDL and PoE name spaces and keep it as
> close as possible to the IEEE 802.3.
> Same is about ethtool interface. 

Ok, it will add more code duplication but indeed, it will be more flexible
for future standard evolution. I will go for this solution then.

