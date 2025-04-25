Return-Path: <netdev+bounces-185787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59593A9BB94
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78787ACAE6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9EC81E;
	Fri, 25 Apr 2025 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQqKDjKi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C663C819
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745539771; cv=none; b=mIr16FJaeECGdYYaARiEF9svX8T3W09Z8RcHS3ExLD1JEO74VNxZic7ncMKsybgJzUJfUHzpk5fNZYXMsOjNykm/16u1MOn29F6rg4tAjMwiKYjSDTeDWarfIq7Om9r5MQqjgGBKaWUDddqNr6Jud9BkLi7GrdBprPQTqZ71DuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745539771; c=relaxed/simple;
	bh=X27dZXbBf1UyTh3wlr1veO6Mj5ruoi4P1bv5CB1QzcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LV9aNdmzVrg4ajeAIJiByu5HRbOmu8+F/49tKm0Yx20SYag2pnrPd2HUaZy/egW/Y6gNcWMxc4fCxEkyUWtXt/Q0RTBVD0BnWDf7xfMXzZL/ga2f+EpAGtt54IZCh4DwL3JroTnF0Z64U5LU736JQ/FZjr4VO1qC0VD2yHudrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQqKDjKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C951AC4CEE3;
	Fri, 25 Apr 2025 00:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745539771;
	bh=X27dZXbBf1UyTh3wlr1veO6Mj5ruoi4P1bv5CB1QzcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RQqKDjKiwOzHkH5YWJteDczIvLI7JWjNDaSlgbSp2xjrWlVs3wKE5/q//I6dz3yvY
	 gnFIU3wLzuJFFileOJ4nbtcMkAuVHtH+LecSU7UqZuZCA+K9wRA0zXWA38wB3c0AwH
	 cnaevBn7myWAiQxyB4G9Rk8mgGjD+Prl1asQvbWxSSrjaJXpw7OFYC6VDRPNEm62+9
	 ns4KP5gxxqpp9ieOuYVUgoAZaTrOj3EMORvAjQ9H4Gmu1AUY1G+9aTztV4ZLaWHxUp
	 0QiJKQWLs2ZPxaYB6/dBLYh/h27VxD/rMaLC/IwVBHTvOoK03zm80rHcC91WKNTApI
	 Tj2M4uTp2F7Ag==
Date: Thu, 24 Apr 2025 17:09:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net v3] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <20250424170929.3fb25bb8@kernel.org>
In-Reply-To: <b3ad22c0-bc58-41e5-8d62-a3bc8d7dccbe@intel.com>
References: <20250422-airoha-en7581-fix-ppe_mbox_data-v3-1-87dd50d2956e@kernel.org>
	<c34ef8a0-20fd-4d0b-84cc-8f829f4be675@intel.com>
	<aAjNC7zUrhc2Ma0z@lore-desk>
	<b3ad22c0-bc58-41e5-8d62-a3bc8d7dccbe@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 09:34:49 -0700 Jacob Keller wrote:
> >> One oddity here is that the structure is not marked __packed. This
> >> addition of a u8 means there will be a 3-byte gap on platforms which
> >> have a 4-byte integer... It feels very weird these are ints and not s32
> >> or something to fully clarify the sizes.  
> > 
> > yes, you are right. Let's hold on for a while with this patch and let me ask
> > Airoha folks if we can "pack" the struct in the NPU firmware binary so we can use
> > __packed attribute here. In any case I will use "u32" instead of "int" in the next
> > version.  
> 
> Sure. Also, if firmware already has this layout fixed, you could add the
> 3 padding bytes marked as reserved to make it more obvious they exist
> without needing to remember the rules for how the members will align.

+1 FWIW, mark the padding explicitly is good, but don't make everything
misaligned with __packed

