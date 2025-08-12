Return-Path: <netdev+bounces-213042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC5B22E63
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF3157A937B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44352FAC18;
	Tue, 12 Aug 2025 16:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250E1EF38C;
	Tue, 12 Aug 2025 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017851; cv=none; b=oFsuXaPz8+aV1NOPm5VAA/D92rqQemF6nrRhsRrBYX8aYXrSaak3C3IEuSQvPBFlGrwkxxlvODy2o8eZ89p8e7B5V0xnWGQGLEV4pH7UGXg4lyyHBNARDcWnDrqqVjqlBY4rlSPJ8M8buqT3S3avM8X2ejjEl68khGB1uDp5iRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017851; c=relaxed/simple;
	bh=9WbRoNPQdqW9aicyq9WoJvTlyyNdGdtCuG3pdzWKRC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H90SAluWtqOk5xXqyYyZiWeAsKFqmT/JiKCWu8Fe8fvlZTb3Io5q4JZXDpjOQbk5k/Q1L+8jiyy5x43NP4o7z362uzP9r6uGqfhI6azG/xd5o5rWuYnLix7O5L+G7KARSjDQvJCjxW1M6BUa95+0OPoSDr/bsXYyXd0SGTAlpKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ulsJQ-000000001OT-0wjF;
	Tue, 12 Aug 2025 16:57:24 +0000
Date: Tue, 12 Aug 2025 17:57:20 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [ANN] netdev call - Aug 12th
Message-ID: <aJtycOgN-QL7ffUC@pidgin.makrotopia.org>
References: <20250812075510.3eacb700@kernel.org>
 <aJtvp27gAVz-QSuq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJtvp27gAVz-QSuq@shell.armlinux.org.uk>

On Tue, Aug 12, 2025 at 05:45:27PM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 12, 2025 at 07:55:10AM -0700, Jakub Kicinski wrote:
> > Hi!
> > 
> > The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> > 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> > 
> > Sorry for the late announcement, I got out of the habit of sending
> > these. Luckily Daniel pinged.
> 
> Only just seen this. Apparently, this is 4:30pm UK time, which was over
> an hour ago.

I was also confused by the date in the subject (August 12th) and the mail
body saying "tomorrow" which is the 13th...
So tomorrow (13th of August) it is?


