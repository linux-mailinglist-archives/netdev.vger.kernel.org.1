Return-Path: <netdev+bounces-53735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDE38044D6
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443AE1F212CE
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185856117;
	Tue,  5 Dec 2023 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUviNjSM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845117F5;
	Tue,  5 Dec 2023 02:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51F6C433C7;
	Tue,  5 Dec 2023 02:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701743250;
	bh=ZwC3qSAZfYKEV4lmUPujpx9iFrtL2THK5cK6G6Kv+18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LUviNjSM3lDsbgdG0110/E4gueBM0mni3upUVnXg6VDKol6i+x92wx4p4RJauOJty
	 +pLQ9GMXxXwYjjBp/m6pCHKy6EfYc/HUP5Ds9q1rIL/n7HI367HLQGfQbgFNqxBQd3
	 leoMciv2/0RQvv6xRDLz+z9EmK3s2RJDKp3dTkefC0L2sbZBNsZRqsQ9/pNuAAmqK8
	 e31ApknJcB4JQ9jJSOKVle5lYO78V+zzRmh8wQoSAIZL30r4mgZKyAJ4VScjrxeC34
	 7mmYA91rQ7/H4iQI+gImhaONP7OR5dTOU6Cxw0wihFnpZoBydY+xZwB4CyhBoQO3wo
	 4M8G/xA6MujGg==
Date: Mon, 4 Dec 2023 18:27:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Grant
 Grundler <grundler@chromium.org>, Hayes Wang <hayeswang@realtek.com>, Simon
 Horman <horms@kernel.org>, =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
 netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>, Alan Stern
 <stern@rowland.harvard.edu>, Hans de Goede <hdegoede@redhat.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] net: usb: r8152: Fix lost config across
 deauthorize+authorize
Message-ID: <20231204182727.1a52ae59@kernel.org>
In-Reply-To: <20231201183113.343256-1-dianders@chromium.org>
References: <20231201183113.343256-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 10:29:49 -0800 Douglas Anderson wrote:
> Since these three patches straddle the USB subsystem and the
> networking subsystem then maintainers will (obviously) need to work
> out a way for them to land. I don't have any strong suggestions here
> so I'm happy to let the maintainers propose what they think will work
> best.

No strong preference here, on a quick read it seems more like a USB
change than networking change, tho, so I'll defer to Greg unless told
otherwise.
-- 
pw-bot: not-applicable

