Return-Path: <netdev+bounces-129793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D9C9861F3
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 17:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829A81C26C7D
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400EF26AF7;
	Wed, 25 Sep 2024 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jACK6DmJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F81D5AA5
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275967; cv=none; b=rC/AQse0IQTiDU3O1K1/JV4RYc50x64dY+NrQFI6av1ANSuo+2xR+grRwAVfU4PSTtnx8SK7xQ/xVExoXdRej9iTxs39XxywUFULlfPDCOO1W+bwFAuGGdAePAjZq5aQuW4NQ4Czldyj5MbIrYfSIMZ8O8kCVMdZsDEWSIOW1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275967; c=relaxed/simple;
	bh=7wZc0Ne6lDpRNHSbye2N6qdDGweZ6dN/NGKbyikYX00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ipVBeeG+EK4z6HWglYX/RTOnGaE9HY749WjZqXfTVKHrtHm7r22iJ9ZP4xLdctsPzAeE2NKhciTOlzt2+Ds6cXX3C6GmBGsD4BHIAMbQp5Od8dZQ8JHi7NaVs77yOO9H4VtDaGq3a+7ofF/sZswzsusAtLNfkvYvrkY5pir32dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jACK6DmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A300C4CEC3;
	Wed, 25 Sep 2024 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727275966;
	bh=7wZc0Ne6lDpRNHSbye2N6qdDGweZ6dN/NGKbyikYX00=;
	h=Date:From:To:Cc:Subject:From;
	b=jACK6DmJi56VSBuACdvkfwwlcgjRC+Is6cHI0LXGoPNGiTojbkAKu+JglNc7UJV2m
	 aVEqmbyQXp8Qm7VWWJNpYjHOV5XRtTOJeV0zXvpKX0Sz4Rb6kCCkgqySm9tEqb0kaT
	 cJ278hl6iXVEWCrIjuXXGUCKQ8rWUiRRNHDjSea4=
Date: Wed, 25 Sep 2024 10:52:45 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Denis Kirjanov <dkirjanov@suse.de>
Cc: netdev@vger.kernel.org, helpdesk@kernel.org
Subject: Bouncing maintainer: Denis Kirjanov (SUNDANCE NETWORK DRIVER)
Message-ID: <20240925-bizarre-earwig-from-pluto-1484aa@lemur>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Denis:

You are listed as the sole maintainer for the following subsystem:

    SUNDANCE NETWORK DRIVER
        M: Denis Kirjanov <kda@linux-powerpc.org>

This address is bouncing, so please send out a patch updating MAINTAINERS and
adding an entry to the .mailmap file with your preferred new destination.

Best regards,
--
Konstantin Ryabitsev
Linux Foundation

bugspray track

