Return-Path: <netdev+bounces-16229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C8574BF46
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 23:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A68C2811A4
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 21:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A5C121;
	Sat,  8 Jul 2023 21:23:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E6185C
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 21:23:06 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3779194
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TdGe8Fgl5BGa9Fw6gbF4siXqHDKNek9Y/GIC0+cz8nw=; b=qM8LmgxoGBudqApncG0G4+uaoL
	YFlbK7qJky4TE3r7F6SvClg9aue5wf7Xbai5J32C09kt4FrC8kHup5MEZPE/iUgn2T7LO9i1+EdjZ
	h6CZrrYck+tlFzjoDWtZuL7a7MBWp3A/tRiBbAVKfda7w0TFZVk7UM3yS5h2RBlP8IKw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qIFOR-000pl9-8o; Sat, 08 Jul 2023 23:23:03 +0200
Date: Sat, 8 Jul 2023 23:23:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stephen Hemminger <stephen@networkplumber.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Subject: Re: Fw: [Bug 217640] New: 10G SFP+ and 1G Ethernet work at 100M on
 macchiatobin
Message-ID: <1ae37aef-299c-400d-9287-ba5ab85637f7@lunn.ch>
References: <20230707075919.183e6abc@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707075919.183e6abc@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adding Russell King.

       Andrew

On Fri, Jul 07, 2023 at 07:59:19AM -0700, Stephen Hemminger wrote:
> 
> 
> Begin forwarded message:
> 
> Date: Thu, 06 Jul 2023 23:23:02 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 217640] New: 10G SFP+ and 1G Ethernet work at 100M on macchiatobin
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=217640
> 
>             Bug ID: 217640
>            Summary: 10G SFP+ and 1G Ethernet work at 100M on macchiatobin
>            Product: Networking
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: alpha_one_x86@first-world.info
>         Regression: No
> 
> Hi,
> Since I upgrade linux kernel from 5.10.137 to 6.1.38 all my interface of
> macchiatobin work at 100M (90 Mbits/sec detected by iperf)
> ethtool detect the link at correct speed (10G for SFP+ and 1Gbps for ethernet)
> What can be the regression?
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are the assignee for the bug.
> 

