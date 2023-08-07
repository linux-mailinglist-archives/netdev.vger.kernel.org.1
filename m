Return-Path: <netdev+bounces-25055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E7D772CC6
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6FB281216
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7405156C8;
	Mon,  7 Aug 2023 17:24:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1703C2B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B70C433C7;
	Mon,  7 Aug 2023 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691429048;
	bh=yzYxk54oxZUBgAaJwMtLsxtiDTx1ixEvK0h1G7PwdS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BFQt7RcOU7f236ghJMxfl6I3L2M29oyDzMj+NAcB5SraIoXMn28oE3F7FwHv6062b
	 xKXp5I5Ctdo8oGIs+wsprPbqEnw7iVSqBzVxwMZIbaZbOlYOFWAhsUklxcXF8JRc30
	 AxsN93ZR68NgDgGVBOFVrHOspco7u4rVWUw0oRIAgv0Q7xfoTwYamUZU0srut4zNkg
	 +gIoH3oRYiH1bkkkSZ9PZOCRiT88jJ2mquOcvrJjC7zSHsjKV5ew23jNMuLg7E+mfU
	 k4iSOwyJ4lLuHi5+jKIS4x2SRrnIL8jj6R8F0abyOKrtWC/gcfjurwqhdcayg+4xhD
	 JgdFZHXvN/WQA==
Date: Mon, 7 Aug 2023 10:24:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple
 cmds
Message-ID: <20230807102406.19a131d3@kernel.org>
In-Reply-To: <ZNEl/hit/c65UmYk@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
	<20230804125816.11431885@kernel.org>
	<ZM3tOOHifjFQqorV@nanopsycho>
	<20230807100313.2f7b043a@kernel.org>
	<ZNEl/hit/c65UmYk@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 19:12:30 +0200 Jiri Pirko wrote:
> >How does the situation look with the known user apps? Is anyone
> >that we know of putting attributes into dump requests?  
> 
> I'm not aware of that.

I vote to risk it and skip the nest, then :)

