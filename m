Return-Path: <netdev+bounces-39137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C9F7BE2D4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204791C20A6B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D1A613E;
	Mon,  9 Oct 2023 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dE2EEucG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454C358A5;
	Mon,  9 Oct 2023 14:31:11 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072CB9D;
	Mon,  9 Oct 2023 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mAnlk2VscIAHKLvNs6CIvKgd0sNcormmavzwsv8+jTE=; b=dE2EEucGHja60SDqQFrUE0GAmj
	bzyo0/+SuOx70vebNEvSuR43B2JfaTP7rer8jpY8JTEi8cKwx5UkRB1xGEy5MihpKdyTOjOi+hBSj
	5g9j8pm4kbY1kencOE2Y1/qqqeKq5A+WOcAlWKk9EYLklZ+dGy5/3O54nXL2KXaAR83g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qprHk-000u8u-Pn; Mon, 09 Oct 2023 16:31:04 +0200
Date: Mon, 9 Oct 2023 16:31:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <fd715b79-3ae2-44cb-8f51-7a903778274f@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-4-fujita.tomonori@gmail.com>
 <ZSOqWMqm/JQOieAd@nanopsycho>
 <bdfac30f-364f-4625-a808-fcffab2f75b4@lunn.ch>
 <CANiq72k4F4EY-cLYMsRFsAnjd9=xyMN_4eHS9T7G1s=eW7kHjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72k4F4EY-cLYMsRFsAnjd9=xyMN_4eHS9T7G1s=eW7kHjw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > I hope some sort of lessons learned, best practices and TODO list can
> > be distilled from the experience, to help guide the Rust Experiment.
> 
> I appreciate that you are taking the time to have a look at the Rust
> support, but please note that most things you are mentioning are not
> really "lessons learned" -- they were things that were already known
> and/or worked on.

We are at the intersect of two worlds here. Maybe these issues are
well known in the linux for rust world, but they are not really known
to the netdev world, and to some extend the kernel developers /
maintainers world. We need to spread knowledge between each world.

So maybe this "lessons learned" is not really for the Rust people, but
for the netdev community, and kernel developers and Maintainers in
general?

	Andrew

