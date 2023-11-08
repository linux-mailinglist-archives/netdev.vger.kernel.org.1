Return-Path: <netdev+bounces-46636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA6C7E57E3
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 14:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98031C208EE
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 13:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864419441;
	Wed,  8 Nov 2023 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B+LVhMV8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B682CA8
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 13:19:35 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379EB1BE3;
	Wed,  8 Nov 2023 05:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2bEwq9z9zdLgqr1oNBum/ilykSY2OlKgUE6VnESOsXo=; b=B+LVhMV85AOcG2XkksDQfsH6rI
	A377+bP5A1Sa38CzA4eDua1bB4lO3qyZ1Rxm1/Sm9lwQcZ+kXsy4jcx+2/Zp6XowJUzW8111s+7sK
	3bLTfmwakrIK2rKNWgrHPh9dLRa0Aa30fd+8ABXnQdFW2JCfC5KxK3oUHZVT7B0SVSYU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r0iSx-0017v4-Kv; Wed, 08 Nov 2023 14:19:31 +0100
Date: Wed, 8 Nov 2023 14:19:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	netdev-driver-reviewers@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [ANN] netdev development stats for 6.7
Message-ID: <ff7104c9-6db9-449f-bcb4-6c857798698f@lunn.ch>
References: <20231101162906.59631ffa@kernel.org>
 <ZUt9n0gwZR0kaKdF@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUt9n0gwZR0kaKdF@Laptop-X1>

On Wed, Nov 08, 2023 at 08:22:55PM +0800, Hangbin Liu wrote:
> Hi Jakub,
> On Wed, Nov 01, 2023 at 04:29:06PM -0700, Jakub Kicinski wrote:
> > Top reviewers (thr):                 Top reviewers (msg):                
> >    1 ( +2) [42] RedHat                  1 ( +2) [71] RedHat              
> >    2 (   ) [27] Meta                    2 ( -1) [52] Meta                
> >    3 ( +2) [23] Intel                   3 ( +2) [46] Intel               
> >    4 ( +2) [15] Google                  4 ( +2) [33] Andrew Lunn         
> >    5 ( -1) [12] nVidia                  5 ( +2) [29] Google              
> >    6 ( +1) [12] Andrew Lunn             6 ( -2) [23] nVidia              
> >    7 ( +3) [ 7] Enfabrica               7 ( +4) [14] Broadcom            
> 
> I just noticed this stats report from Simon. Thanks for your work and
> sharing. I want to know if there is a way to bind my personal email
> with my company so my review could increase my company's score :)

Jonathan Corbet <corbet@lwn.net> maintains a list of email addresses
to organisations mapping. Let him know who you work for and the next
cycle you should count to your company.

      Andrew

