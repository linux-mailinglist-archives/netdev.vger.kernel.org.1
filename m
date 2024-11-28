Return-Path: <netdev+bounces-147712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749869DB565
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 11:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E3828373D
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E518A950;
	Thu, 28 Nov 2024 10:09:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0014D70F
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788584; cv=none; b=bK0nCsYo1qvr3qGftt5d3ZHhq8Da9oXu1wBC2Pk7WR3x2FkttEeJWrFBBRvEFkjrAxKGE0G0lTZkKqeKYLn/IqALriK9soe3jBDALaBLY08JdEVMka3MoE4tF0mdgP71W0bF2V/NlBBdqe+nOtTCm0TASFMZPBl9dRpAhxeqVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788584; c=relaxed/simple;
	bh=t4pt1e7Pm7Bw+XbC5tkYEIN3LyopXTuatJ5g8DJ3iEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9Yr5pg3+D/kyq95q8ILwS2hl9YatoU/Jdwza1XXCIAwA89pXx1XitU8vAorOVS9RMeT0hEYC3/JElrYJgtAwwB8BiaYr4vrcGjTbV3u6MB0FI96ExdyKWmNzn4Ra1ApsmKzH4dIjmQHeYcbKH+mEr9yBvBJ+LEc9tSmWoS4SbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tGbSs-0005pb-BJ; Thu, 28 Nov 2024 11:09:38 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGbSr-000b0E-16;
	Thu, 28 Nov 2024 11:09:38 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGbSs-002rwx-03;
	Thu, 28 Nov 2024 11:09:38 +0100
Date: Thu, 28 Nov 2024 11:09:37 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool v2] ethtool: add support for
 ETHTOOL_A_CABLE_FAULT_LENGTH_SRC and ETHTOOL_A_CABLE_RESULT_SRC
Message-ID: <Z0hBYTCNeZTIU52A@pengutronix.de>
References: <20241128090111.1974482-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128090111.1974482-1-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Sorry, I forgot to add ethtool notation to the subject.

On Thu, Nov 28, 2024 at 10:01:11AM +0100, Oleksij Rempel wrote:
> Extend cable test output to include source information, supporting
> diagnostic technologies like TDR (Time Domain Reflectometry) and ALCD
> (Active Link Cable Diagnostic). The source is displayed optionally at
> the end of each result or fault length line.
> 
> TDR requires interrupting the active link to measure parameters like
> fault location, while ALCD can operate on an active link to provide
> details like cable length without disruption.
> 
> Example output:
> Pair B code Open Circuit, source: TDR
> Pair B, fault length: 8.00m, source: TDR
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

