Return-Path: <netdev+bounces-16951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5074F8CD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 22:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62641C20DFC
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 20:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646A91EA7E;
	Tue, 11 Jul 2023 20:12:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698E1DDCB
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B42DC433C7;
	Tue, 11 Jul 2023 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689106326;
	bh=MdUZCeeACrV8lco8xyZoWWdINdlukQxVGZTpoYXp6p8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m9M7R6kX71CNU0VZH2rXNxmpcxlYVKMeYYYJLFYVO0Mw+J7PJ3GHvC7nMZW9lpjW2
	 ELz43uOuJVVsC3Zoa8MsCUyNY+FclFXEpmGldE3RkIPOnDYZHYM5sAWDktQjhsPdNh
	 T79DdgZgK5kOiivDsRLh7Wsv/dKha6xjrSQLP294bgSJKnn/8dFATGNdc617BODjNB
	 Lpnx0p2VQlbU6JBkv8yWDGF4dLRaPKi/FxIaR7HDla3bSx/P2rZy06Ibl9fMF9RMW+
	 UKGRIMjjoV6HSr5r2/iRiSfU+7l4V094NWif5n4TWSeH6SEGY8T4yCuSObKjj/9f9E
	 cVD5LTMDXWnvA==
Date: Tue, 11 Jul 2023 13:12:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "David S. Miller" <davem@davemloft.net>, Oliver Neukum
 <oneukum@suse.com>, netdev@vger.kernel.org, USB mailing list
 <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] net: usbnet: Fix WARNING in
 usbnet_start_xmit/usb_submit_urb
Message-ID: <20230711131205.53b3e5e4@kernel.org>
In-Reply-To: <38ff51d4-2734-4dd7-8638-ae2fc8572c0d@rowland.harvard.edu>
References: <000000000000a56e9105d0cec021@google.com>
	<000000000000e298cd05fecc07d4@google.com>
	<0f685f2f-06df-4cf2-9387-34f5e3c8b7b7@rowland.harvard.edu>
	<7330e6c0-eb73-499e-8699-dc1754d90cad@rowland.harvard.edu>
	<413fb529-477c-7ac9-881e-550b4613d38c@suse.com>
	<38ff51d4-2734-4dd7-8638-ae2fc8572c0d@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 13:38:00 -0400 Alan Stern wrote:
> +		u8		ep_addrs[3] = {
> +			info->in + USB_DIR_IN, info->out + USB_DIR_OUT, 0};

With the two-tab indentation and the continuation line starting
half way thru.. this looks highly unusual. Can we use a more
standard kernel formatting in this case?

		u8 ep_addrs[3] = {
			info->in + USB_DIR_IN, info->out + USB_DIR_OUT, 0
		};
-- 
pw-bot: cr

