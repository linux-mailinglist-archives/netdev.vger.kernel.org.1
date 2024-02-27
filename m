Return-Path: <netdev+bounces-75173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B9868748
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 03:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0434A1C24B5F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 02:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C611CAF;
	Tue, 27 Feb 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6od7+rI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1991CA81
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001422; cv=none; b=vCC93nihMUJVXkrOGLooGS4pFaNBZUELrPisbzNwiSjIxrL3Ca8nUKHH1//33EkM+lKKPa6b6vLuUI1fUY++3W5R38Uy0MQxaMOw2LNtN0gkqiImkyNxiYxpM3EMJ5rZDMwvTtvKsULNcr3b6y9xYwuqtg90+uX4euazFErKsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001422; c=relaxed/simple;
	bh=NPHkntyNQWs/c+91Q/vIgp3rM+4cUdlquzRTakc8a70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGDz6QnMFXf/nSVcviuXcyk2laAJYob0ofHTxhKsi1C1v8uJEjK3O9aq0JmSClpPtuFYmS+cpSnhPnWTSfkhcPQJE4q3FdkXUyajvTvNnybyZ58nmgAfTJPYHze4z0gVcn/2Re1UyZ6oU4gjguPCylUH0KyjFmeXoZgBLhsvi7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6od7+rI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB64CC433C7;
	Tue, 27 Feb 2024 02:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709001421;
	bh=NPHkntyNQWs/c+91Q/vIgp3rM+4cUdlquzRTakc8a70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g6od7+rIBZNSmCzw7lJF7UMevm/THf6dbI783m5tG5mmsEjM1Fvzh2HS0c0yrmcNw
	 UJkoig4YMJr1Mjj1PWWIS9ys+DX4oV0LjYq+d9X2vu+kWSgkmk9TeGt9YeELLKaCcD
	 wAJSVVLx3VP9PDs02pS15FsXNq1rAeX2irbWxp3lCrMrLqbLGRP2RJJOQaokqf6389
	 Yz2dwmiYZ40+k4Tb6+IaSaIPOckpoiy0N+h55NRxsOyTg16OmQwo2j72+Wis7k5Zuf
	 mGqkfsU5xro5G4YMdQFrK0wvZOlNLJknTMV1ZcRLFK02P931xbDNUTx5xDXr+LURtF
	 i+0F+KcjxsTnQ==
Date: Mon, 26 Feb 2024 18:37:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <20240226183700.226f887d@kernel.org>
In-Reply-To: <ZdrpqCF3GWrMpt-t@nanopsycho>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
	<20240219100555.7220-5-mateusz.polchlopek@intel.com>
	<ZdNLkJm2qr1kZCis@nanopsycho>
	<20240221153805.20fbaf47@kernel.org>
	<df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
	<20240222150717.627209a9@kernel.org>
	<ZdhpHSWIbcTE-LQh@nanopsycho>
	<20240223062757.788e686d@kernel.org>
	<ZdrpqCF3GWrMpt-t@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 08:18:00 +0100 Jiri Pirko wrote:
> >Do you recall any specific param that got rejected from mlx5?
> >Y'all were allowed to add the eq sizing params, which I think
> >is not going to be mlx5-only for long. Otherwise I only remember
> >cases where I'd try to push people to use the resource API, which
> >IMO is better for setting limits and delegating resources.  
> 
> I don't have anything solid in mind, I would have to look it up. But
> there is certainly quite big amount of uncertainties among my
> colleagues to jundge is some param would or would not be acceptable to
> you. That's why I believe it would save a lot of people time to write
> the policy down in details, with examples, etc. Could you please?

How about this? (BTW took me half an hour to write, just in case 
you're wondering)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 4e01dc32bc08..f1eef6d065be 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -9,10 +9,12 @@ level device functionality. Since devlink can operate at the device-wide
 level, it can be used to provide configuration that may affect multiple
 ports on a single device.
 
-This document describes a number of generic parameters that are supported
-across multiple drivers. Each driver is also free to add their own
-parameters. Each driver must document the specific parameters they support,
-whether generic or not.
+There are two categories of devlink parameters - generic parameters
+and device-specific quirks. Generic devlink parameters are configuration
+knobs which don't fit into any larger API, but are supported across multiple
+drivers. This document describes a number of generic parameters.
+Each driver can also add its own parameters, which are documented in driver
+specific files.
 
 Configuration modes
 ===================
@@ -137,3 +139,32 @@ own name.
    * - ``event_eq_size``
      - u32
      - Control the size of asynchronous control events EQ.
+
+Adding new params
+=================
+
+Addition of new devlink params is carefully scrutinized upstream.
+More complete APIs (in devlink, ethtool, netdev etc.) are always preferred,
+devlink params should never be used in their place e.g. to allow easier
+delivery via out-of-tree modules, or to save development time.
+
+devlink parameters must always be thoroughly documented, both from technical
+perspective (to allow meaningful upstream review), and from user perspective
+(to allow users to make informed decisions).
+
+The requirements above should make it obvious that any "automatic" /
+"pass-through" registration of devlink parameters, based on strings
+read from the device, will not be accepted.
+
+There are two broad categories of devlink params which had been accepted
+in the past:
+
+ - device-specific configuration knobs, which cannot be inferred from
+   other device configuration. Note that the author is expected to study
+   other drivers to make sure that the configuration is in fact unique
+   to the implementation.
+
+ - configuration which must be set at device initialization time.
+   Allowing user to enable features at runtime is always preferable
+   but in reality most devices allow certain features to be enabled/disabled
+   only by changing configuration stored in NVM.

