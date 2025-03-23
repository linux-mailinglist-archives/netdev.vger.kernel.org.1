Return-Path: <netdev+bounces-176968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311BAA6D034
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 18:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E557A7A513E
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3267D13B29B;
	Sun, 23 Mar 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMQhb/Oz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92178F4E
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742750343; cv=none; b=jTZ7bOuFsFrNSTKOBVGLMOKDVqPOorNWguUzlKirHWN65YatGLFDMKeZHBd2fTpFXqfxPDAy8LiPn3j1D2qPolA4aCRkI2zQYKWxzQeTWe/6GV6Tk+Es1ApgftaYcNbcFxFbW4sPdFtxhW5AjGXrBzFR4NQb2RGW7700M9J1pRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742750343; c=relaxed/simple;
	bh=TfPf7akZgz+m4rkjCC/HSYQVbPzwNid44QbMOFcuw0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBEHgMHmQTVQBflBctspjweeQK+QL2JRQQPizrFvrHhViETeXEebXHdHzQbHL5rz5Aixp2RzU274nys0K8o5oQxRKN60fmu2glFeH1/CVt0ivprFIOsnMCA8DDOXsvWLPL89CBw+bQ5Sf/D4/n16eVWxgYhnVYPYueWTpSY5ntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMQhb/Oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD9AC4CEE2;
	Sun, 23 Mar 2025 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742750342;
	bh=TfPf7akZgz+m4rkjCC/HSYQVbPzwNid44QbMOFcuw0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMQhb/OzxBNoO9jh5+khBI4D3jCNzL274C39kiLSYd9Dxc8U/wv52amuF4C0O/WrP
	 I8pu/hhFBG9cZ+/pPaVRZuHT7TOCmGqxuAwke8xv2ec5TEuYSOarOI9alDTIml/QdR
	 C5cABZ809AHuRtJL2GWk/4kaE2Bh35iPEEAhtEvlajXGd8ACsR6QR/70Jz6zZXZgdB
	 t/JeY4mA4uzksdb8bmdjBJa3NKYA0RQPvALg+di1umoxTYfe1aZOWoHGZKdLZXZjYV
	 Qe5Ms9AoCkeZZXiAnZxPbI5FiVaJRuWHxGaGTRYH5GfwMsAxvzrTwFDYADmqr/j+OM
	 iikI0HiOmJuJg==
Date: Sun, 23 Mar 2025 17:18:56 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next 3/4] devlink: add function unique identifier to
 devlink dev info
Message-ID: <20250323171856.GW892515@horms.kernel.org>
References: <20250318153627.95030-1-jiri@resnulli.us>
 <20250318153627.95030-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318153627.95030-4-jiri@resnulli.us>

On Tue, Mar 18, 2025 at 04:36:26PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Presently, for multi-PF NIC each PF reports the same serial_number and
> board.serial_number.
> 
> To universally identify a function, add function unique identifier (uid)
> to be obtained from the driver as a string of arbitrary length.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


