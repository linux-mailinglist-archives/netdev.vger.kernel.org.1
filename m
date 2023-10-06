Return-Path: <netdev+bounces-38664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBC97BBFBE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 21:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E211C20863
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 19:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924233E46E;
	Fri,  6 Oct 2023 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESlrKQus"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD938F90
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 19:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B970AC433C8;
	Fri,  6 Oct 2023 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696620824;
	bh=TZa4ECaf5pdgfpneuFd4EaBuwVX5i6V8hUt4o09+mJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ESlrKQuswqYmbv0Amo8aZJp4JRavjDAySLt7V4xFmZAWiXRYP5FrmTK50qVrGwG34
	 zetAetbmXm7EoNJKB3COZm2GV0MTS4gud3hfXnGOjnAsLlzeDixp7F2afpdCqWmVbr
	 B3gL/Ag3R4dTLobT2YEGGKQ2dFjXXXkEQadqdJ13b/i40SH460HYDiXuY34nUvzgWL
	 WkBUEb9x4BKa/bn9UCtuKhdV+SnjvkhY/p4PRcNz9v1J5SyIHN4l0UTsnSvZzmLbsN
	 H1MTnPR3qU1bfe9+Er5HWHD9ePSq0KPbj8STBQtt5L40zacD+L3Jg3kZ3lxEONe2gc
	 DrAMXV81W8hJA==
Date: Fri, 6 Oct 2023 12:33:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next v3 1/2] tools: ynl-gen: lift type requirement
 for attribute subsets
Message-ID: <20231006123342.5c82cda7@kernel.org>
In-Reply-To: <ZSA8CVP6+DnPrHly@nanopsycho>
References: <20231006114436.1725425-1-jiri@resnulli.us>
	<20231006114436.1725425-2-jiri@resnulli.us>
	<20231006080039.1955914d@kernel.org>
	<ZSA8CVP6+DnPrHly@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Oct 2023 18:55:37 +0200 Jiri Pirko wrote:
> Took me like 3 hours debugging this. These json schemas are from
> different world than I am...

That makes two of us. One of the most confusing languages I've worked
with.. The effort is very much appreciated! :)

