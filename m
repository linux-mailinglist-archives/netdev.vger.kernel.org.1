Return-Path: <netdev+bounces-27426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079EC77BF36
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC0F1C20AAD
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA789CA40;
	Mon, 14 Aug 2023 17:46:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA366BE6B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 17:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03940C433C7;
	Mon, 14 Aug 2023 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692035194;
	bh=vngkS6znGQvw6Z9paQ4jG4QkE3P/fBG53d6K9g48mvM=;
	h=Date:From:To:Cc:Subject:From;
	b=VLaDvGfTilnLUidO5x9ZYI/5LqxUrbx3r1icLM3eGdS59eJirmwxzbuBuQR3msjZX
	 3CMSX37lxalm2+Or327Dz5b0mEzcOTDlG23CIJujf4CabLfUXPMtJwbkJFM87PO8KO
	 jvM2erd54FMDmsyp5siBA512Jk0S+8Ep4d8UE8cmGCkgThD6COPyz29ITcYI3IpKvj
	 kz2jODp0fifnvXOrIW/kqoxsHQwdR12cKh0b6aj/soDT8LeFJYMNf16rD+fUfxL9qh
	 hMJ9HlSeoah30erHRDkeHFPQkuZMm2RGhMqkR2B4mROU5rhD0flqscmPbgIFWfwqzd
	 4DNx6AOYS7AlQ==
Date: Mon, 14 Aug 2023 10:46:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, Ido Schimmel <idosch@idosch.org>,
 Gal Pressman <gal@nvidia.com>, netdev-driver-reviewers@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>
Subject: [ANN] periodic VC call and HW-specific CI
Message-ID: <20230814104632.4b0b8b95@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

we had been hosting a VC call on BBB every 2 weeks to discuss current
netdev topics, mostly on less technical topics like organizing reviews.
Everybody is invited, if you'd like to attend please select suitable
time in this poll:

http://whenisgood.net/ga9cbki

(please make sure the timezone is correct).

On the most recent call we discussed the possibility of creating 
a KernelCI-like system where vendors could upload test results
for running upstream tests on their HW. At Jesse's suggestion I created
a basic requirements doc for the idea:

https://docs.google.com/document/d/1TPlOOvv0GaopC3fzW-wiq8TYpl7rh8Vl_mmal0uFeJc/

Please request edit rights if'd you like to contribute / comment!

