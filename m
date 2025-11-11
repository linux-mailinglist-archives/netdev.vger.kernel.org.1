Return-Path: <netdev+bounces-237389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC20C49E46
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DC418869EC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442424BBEB;
	Tue, 11 Nov 2025 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utCl2ZYh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91B247DE1;
	Tue, 11 Nov 2025 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821803; cv=none; b=d/+jpEu1nDc5g//UGE1/MM/sh8xBVxvc/w6eKwSg6uiH+jf4jyhf2lRtnmxkaRxgrVkNV33Y7tyCgmdg4NfqAFPfEf9j8uAgb77kZxwAm0P30EqQIycCjcahTbPWExlG4DBSR9ktWGtXtaj7D3EHMwO18toArggTN363wZdCfgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821803; c=relaxed/simple;
	bh=aQeArqxKyqiMvXQolsDGd3I5R4aXdcaJRVDoflzRUiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iO8cqsWOvUZxWWoiB2l9bbnVB4wAHiwT9VnM8wXJUYi1gUUcRSwFCqtR5nbk1bAicNtafDmF4VKgn117QAqHjYbAtgb82i2lOEOfzvnzMv+JLXEobXcdsC8psMSYGPezsW8FSCX/oXNsSyHsuM5CtKj4Xvxb2RNfIudHDQVU8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utCl2ZYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B717BC16AAE;
	Tue, 11 Nov 2025 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762821803;
	bh=aQeArqxKyqiMvXQolsDGd3I5R4aXdcaJRVDoflzRUiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=utCl2ZYhJ/7Jr4dl+PurPoGTgIo6nfwBkRevMjf0q2UP6dFcG+MMW6NGEz1VJNpMf
	 g889g5TOVPnEQFvinZb0cSZYEXxHG5Kn9k4b43l8ziuG/hF2sWqGB/xnd+I+pbH7+4
	 jBHWq+71RT/S+bwZ0jHO7h7dMUPcH8keu70U+cQ023iUc60o+3pQ28M23xHV2XKk9g
	 5Xet84Ih8z/ulgy9uqcvTGibCT51SKN3QTI4PS4C+L9Z3zzA06XtRISZ8bERiMrGmz
	 LDaSG959XK6tgIFk+i0r0vwv8XeS3JM6nzdjJBfantJJGevhW7YtaOCKphLeSa89Pg
	 dcmkcu0VYJ7Dw==
Date: Mon, 10 Nov 2025 16:43:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2025-11-10
Message-ID: <20251110164321.75f7edec@kernel.org>
In-Reply-To: <20251110214453.1843138-1-luiz.dentz@gmail.com>
References: <20251110214453.1843138-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 16:44:53 -0500 Luiz Augusto von Dentz wrote:
>       Bluetooth: hci_event: Fix not handling PA Sync Lost event

nit: sparse says:

net/bluetooth/hci_event.c:5850:22: warning: cast to restricted __le16

(I haven't looked if the cast is correct but if so it needs a __force)

