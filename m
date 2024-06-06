Return-Path: <netdev+bounces-101197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798458FDB97
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2821F24A07
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21BE748F;
	Thu,  6 Jun 2024 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZja4xWp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60BEED6
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717634547; cv=none; b=rpY0Vu3igtwPBni0LCrqSLYz4cPlk5vA1HV5ktVunQp6I+quxnK0Y+AOkOTB6HRA8mC9m4WY6deXtAKG3gdJxRpq8B3ZgyOwtPGQ0Hgapi7x7aSiPf79SX4VYewODh6iKj1fJoNJ7VqR7HcsNdmYmeIcgPJHxdMdesZbOCuboZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717634547; c=relaxed/simple;
	bh=mfk9t6OkOQ6FMiw+9Bp+lQSM+hSNtbVE4eiRYqs+J4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvMk8QWrI/7ccwqU1alL6jwjE4m3xpSSEPzBZ+QAjD44BoLYmm0F9Yz+PSREpqj/F+OU0S9e64wxX6khLtGdeDXFNgIgIkQDT86//+PE/x7XZsFHZ6Rj9GUC/6sPmwWV3Bh/TLThhZrkM058llnO9OAmoCSnKforvvZhNNX71U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZja4xWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB8FC2BD11;
	Thu,  6 Jun 2024 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717634547;
	bh=mfk9t6OkOQ6FMiw+9Bp+lQSM+hSNtbVE4eiRYqs+J4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VZja4xWp9PldlCLhBcYGc4Qj5MUb4aSC0vekod6CGWzi0aq5syNszwwI047yJUHu5
	 nWPw02D5IHLm7EvfFRxnhk/HSYuag9rvk7q0hhwlZsv+Ik+Cx1MnASLHEcV43U3Vrw
	 7zkmp87305DQ1trCxCVT2/HFIJUDFNXXcUsc6/DCzbozWCiyurXpXns47SF0OFbt+6
	 rFyiHodUcAexMxxGMte0ezGJeoCwS1OiKaLhg4XaR0pnhq++nDopa1MtCUeLKGDMbc
	 0lAHKTaTLLwuFtTRYWj4rn8GwkCKNl+ecMYa3Y3lTSLNxavNmpYnI/Je7K02g+7+gR
	 P9OJdqDaONF+Q==
Date: Wed, 5 Jun 2024 17:42:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v4 0/6] add sriov support for wangxun NICs
Message-ID: <20240605174226.2b55ebc4@kernel.org>
In-Reply-To: <3601E5DE87D2BC4F+20240604155850.51983-1-mengyuanlou@net-swift.com>
References: <3601E5DE87D2BC4F+20240604155850.51983-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 23:57:29 +0800 Mengyuan Lou wrote:
> Add sriov_configure for ngbe and txgbe drivers.
> Reallocate queue and irq resources when sriov is enabled.
> Add wx_msg_task in interrupts handler, which is used to process the
> configuration sent by vfs.
> Add ping_vf for wx_pf to tell vfs about pf link change.

You have cut out the ndo_set_vf_* calls but you seem to add no uAPI
access beyond just enabling the PCI SR-IOV capability. What's your plan
of making this actually usable? It's a very strange submission.

