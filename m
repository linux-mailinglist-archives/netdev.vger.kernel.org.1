Return-Path: <netdev+bounces-53739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1401804503
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B508281493
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB420E8;
	Tue,  5 Dec 2023 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b/w5kHwP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F618CA48;
	Tue,  5 Dec 2023 02:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F47CC433C8;
	Tue,  5 Dec 2023 02:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701743679;
	bh=liax+sIHnmEKfEfVW+s4DmqLUntZruIqSMcTRWSs0Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/w5kHwP00LQYOnC9+5b7PG1sxSHiFKwsRB1yDsd5YpDaHD+tSl0X7jbWde2cdt4L
	 xyzfu0VP8pQO9lGfB36ETlCv1oD21KUHIKTVAq7ykuYLNXWUVeTt3CjFi3M0dIu3bE
	 Uv6oZJvVMMkEG9gllT8ApZkUrAyVwSu42Y+khv8Q=
Date: Tue, 5 Dec 2023 11:34:36 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, linux-usb@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Grant Grundler <grundler@chromium.org>,
	Hayes Wang <hayeswang@realtek.com>, Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Hans de Goede <hdegoede@redhat.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] net: usb: r8152: Fix lost config across
 deauthorize+authorize
Message-ID: <2023120521-fervor-subscript-20b1@gregkh>
References: <20231201183113.343256-1-dianders@chromium.org>
 <20231204182727.1a52ae59@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204182727.1a52ae59@kernel.org>

On Mon, Dec 04, 2023 at 06:27:27PM -0800, Jakub Kicinski wrote:
> On Fri,  1 Dec 2023 10:29:49 -0800 Douglas Anderson wrote:
> > Since these three patches straddle the USB subsystem and the
> > networking subsystem then maintainers will (obviously) need to work
> > out a way for them to land. I don't have any strong suggestions here
> > so I'm happy to let the maintainers propose what they think will work
> > best.
> 
> No strong preference here, on a quick read it seems more like a USB
> change than networking change, tho, so I'll defer to Greg unless told
> otherwise.

I took these in my tree already, sorry for not saying anything here.

thanks,

greg k-h

