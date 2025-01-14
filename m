Return-Path: <netdev+bounces-158265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C21A1144F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B137E167AB7
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F8213253;
	Tue, 14 Jan 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjV6omNT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A91FBE86
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894695; cv=none; b=FvHggu0Ce7+/Sz1cXOyp1LvveUTlhjzIU7xGtgWcKk7AlU8uMfji6hW2eAM3cfFGkUE0hQ2zyD+AoDZzx47QN7X9Q9xP5r1FH4gkXD6vbbJOogQHJHwS0o46laDVlCn9A75cQTRaUReaV0cokk5FXBo9H74oSxvxa/wwUn07eRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894695; c=relaxed/simple;
	bh=DL6/k9GeNL8KQ/InqvEK96ZaOckFwix7u2BtNTjNepI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etK8zyOdqsFFjLMtQHQY1A1kYf0zKQ5Kqjw5KBWD60bERnsQeZt/phtP8vVLGSL2MbDPGE5SYimslxgwtw1rJOS3DqHVkKI9YIWzXhEhn7ljJ2oxMAWfvRZ+ERXDRX13YDYqKlY6PSAahV6oyd86Vn6NbMI4iETCWtjllnx/jcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjV6omNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F137C4CEDD;
	Tue, 14 Jan 2025 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736894695;
	bh=DL6/k9GeNL8KQ/InqvEK96ZaOckFwix7u2BtNTjNepI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GjV6omNTruINq1WmxXJoDgKN7/2q9FtUdghsuveUgg77THy22WqeahPllrBZyilAM
	 0/o5H8IPWF6ypzOIObzYgSixsk3Ksgis/Knx5AHPSis7QZBn/eaM6Iee7HdrDFBBZI
	 ZlCzWWOkYn43UJ7f4oTIoZCcssgfzBFIj+XiQKprRrrYNPdscohInXJgkX9SQsm4gn
	 3WTCKYWGO6/IApvlQ4RWARbTLYxKzb641J71GzI/RNL71FO6An1RWoUTg5XbD880Gg
	 RPjUHAtGfTO2GJa66uajbVngxxiqQv1wm4Ac6AxYcoqXTZG8rbT1ThfReIKX0dTr+U
	 4ejNZopU/9U0w==
Date: Tue, 14 Jan 2025 14:44:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, helgaas@kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v6 2/6] net: libwx: Add sriov api for wangxun
 nics
Message-ID: <20250114144454.16bc139e@kernel.org>
In-Reply-To: <20250110102705.21846-3-mengyuanlou@net-swift.com>
References: <20250110102705.21846-1-mengyuanlou@net-swift.com>
	<20250110102705.21846-3-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 18:27:01 +0800 Mengyuan Lou wrote:
> +static int wx_check_sriov_allowed(struct wx *wx, int num_vfs)
> +{
> +	u16 max_vfs;
> +
> +	max_vfs = (wx->mac.type == wx_mac_sp) ? 63 : 7;
> +	if (num_vfs > max_vfs)
> +		return -EPERM;

You should use pci_sriov_set_totalvfs() instead of checking 
the limit manually in the driver
-- 
pw-bot: cr

