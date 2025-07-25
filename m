Return-Path: <netdev+bounces-210157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C859AB12319
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A684E4018
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672DC2EFD93;
	Fri, 25 Jul 2025 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBPmXkuS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8BE1FDA61;
	Fri, 25 Jul 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465353; cv=none; b=aRm5mRIyjThrzn6wd0BW8ucm++fbVB1BdkT8Fz/XmZANjeYZTIcceZ6EA4k2tSh+jaOVdhUWezEf8WObcFbsX8Sc6R0J5Okj2Yki6dHuRW15AoKNFHTD+fGuURde3vPTsI0MRlyoLF877E2Z4fh/W8WQvjIGivqCaYteLWgpklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465353; c=relaxed/simple;
	bh=DLNukM6xeX8mDdNfXUUkU55B99plFgyDwDCwtBLI/ws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXhwx9LC+cDwEXw4ZkmN5SNGnmjISCUBbSnSTzm2+svdHdrBNVWfH4jAJu7k1pdOo6ZVgypFufblYAEsQ1GBvWgUvlgzrThYBWVCwp5sqrWUt6Eiog1KlAg2yqeewp1zF3bm2Niqsljrz7j4XnQXRDynbd6RR5Ju450+SiPMzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBPmXkuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DA7C4CEE7;
	Fri, 25 Jul 2025 17:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753465352;
	bh=DLNukM6xeX8mDdNfXUUkU55B99plFgyDwDCwtBLI/ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UBPmXkuSK6/BZ2AR5onqsfiXkdCUDG0Ni/ipuHLrFMeoe1kLMAlyeI0JkIuZ0BXFA
	 vaxrcJ36vqfmg+pCoOPU7GyqHAHT9NZ/AUkc51p7ARC40cj2hPnvDWwG2OeE+CFDGu
	 4llc13MuAbA9IiAVfDcPhd5q4/Ptu3UN2tf4XRwCDoUhvvJUkqQufg49xmJnnAuXlN
	 M5sJFtMCG8qLebZWIlJsaYCn6evKoLVrclOXBJ859C9KbQqA3MjP8VI3jfZtt6CS4n
	 txnXfJfKdlFQYUN+RTPJ2yMRxdBP9jEFoDLWoOE/ZVc39Ny/G3VCXczcGru5zQP3Ea
	 1aOQZP1lfeS0g==
Date: Fri, 25 Jul 2025 10:42:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next 0/5] dpll: zl3073x: Add support for devlink
 flash
Message-ID: <20250725104231.0307b4d1@kernel.org>
In-Reply-To: <ea9f9931-95d9-4f7d-abba-eb7fae408977@redhat.com>
References: <20250725154136.1008132-1-ivecera@redhat.com>
	<ea9f9931-95d9-4f7d-abba-eb7fae408977@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 19:18:55 +0200 Ivan Vecera wrote:
> Self nacked, need to fix warnings found by clang (not identified by
> gcc).

Thanks for the note, I suppose you updated the patchwork state
yourself? Please prefer using pw-bot commands in networking and bpf.

(BTW net-next is closed already)

Quoting documentation:

  Updating patch status
  ~~~~~~~~~~~~~~~~~~~~~
  
  Contributors and reviewers do not have the permissions to update patch
  state directly in patchwork. Patchwork doesn't expose much information
  about the history of the state of patches, therefore having multiple
  people update the state leads to confusion.
  
  Instead of delegating patchwork permissions netdev uses a simple mail
  bot which looks for special commands/lines within the emails sent to
  the mailing list. For example to mark a series as Changes Requested
  one needs to send the following line anywhere in the email thread::
  
    pw-bot: changes-requested
  
  As a result the bot will set the entire series to Changes Requested.
  This may be useful when author discovers a bug in their own series
  and wants to prevent it from getting applied.
  
  The use of the bot is entirely optional, if in doubt ignore its existence
  completely. Maintainers will classify and update the state of the patches
  themselves. No email should ever be sent to the list with the main purpose
  of communicating with the bot, the bot commands should be seen as metadata.
  
  The use of the bot is restricted to authors of the patches (the ``From:``
  header on patch submission and command must match!), maintainers of
  the modified code according to the MAINTAINERS file (again, ``From:``
  must match the MAINTAINERS entry) and a handful of senior reviewers.
  
  Bot records its activity here:
  
    https://netdev.bots.linux.dev/pw-bot.html
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updating-patch-status

