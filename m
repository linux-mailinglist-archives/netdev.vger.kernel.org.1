Return-Path: <netdev+bounces-150419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C019EA2E2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F7D2823BA
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7142921171C;
	Mon,  9 Dec 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJQvz2io"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06419B3EE
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787362; cv=none; b=f/HcTJM6//QahXGheQna+E0fjxlOr4Rx9ODrinlaM/p1g2x7uFVjjrZHjWGlTwB/GxtAmD06agsmuDfyadGs+B62qw/RDO7qjFKzXAfglixsdD3ubLHb1e+Yw94H21UUUfdwgiuoolGiYXCVNStkANYPcXboq1iQLIdTObWEoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787362; c=relaxed/simple;
	bh=NdPKOSPU4p+DVGjLP/RnkRHeQoLuuHuopki9InkJ7qE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbISDfMic22zYrGyJqhqs0/sisJu5hBm9Hhgn6LXYQwG2MT5LpIjwOVK24HecDs7m7N2RwdUwri4EXtDZnszFUt/sp0jptdDBTS1VS91x46JKBUwAZOpjdIY+M87vYaZsknsiqM6VWSMca5pAlpByz2VytkuWu/Ipwz6JdxAJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJQvz2io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BAEC4CED1;
	Mon,  9 Dec 2024 23:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733787361;
	bh=NdPKOSPU4p+DVGjLP/RnkRHeQoLuuHuopki9InkJ7qE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YJQvz2ioCqHzoIFaOHTTjvfEWLx6aJ4P5iEqEkBIGoP5W0F+2ekCtELI9egY5b577
	 EKefEQyM5oa7o6Ls1DVV6hfk7JEWlS57+k7HS8zOiCl32H0Uk6XOUugHXZ9lwxKlBm
	 VT1xslZ29up9jpmRzs9n5tPkfUQ9Q3gsaba93PzsC+B9M/VsFTNnNH1JXxJ093nNxe
	 u43DX5mKzTTEIaVDUC1y8USigc+wVjKj0bpVDzTaq0DweeH3w3gzhXQ19A/OyaDuxO
	 sJ6XSsTB6QuwHI+ev/kWBiJSqFVlliFepG4xA8PZ4wFvjPYzqkogWBcU8rrDGOoVas
	 i70pwnK0apYqQ==
Date: Mon, 9 Dec 2024 15:36:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, stephen@networkplumber.org, anthony.l.nguyen@intel.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [RFC 0/1] Proposal for new devlink command to enforce firmware
 security
Message-ID: <20241209153600.27bd07e1@kernel.org>
In-Reply-To: <20241209131450.137317-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20241209131450.137317-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 14:14:50 +0100 Martyna Szapar-Mudlaw wrote:
> Proposed design
> 
> New command, `devlink dev lock-firmware` (or `devlink dev guard-firmware`),
> will be added to devlink API. Implementation in devlink will be simple
> and generic, with no predefined operations, offering flexibility for drivers
> to define the firmware locking mechanism appropriate to the hardware's
> capabilities and security requirements. Running this command will allow
> ice driver to ensure firmware with lower security value downgrades are
> prevented.
> 
> Add also changes to Intel ice driver to display security values
> via devlink dev info command running and set minimum. Also implement
> lock-firmware devlink op callback in ice driver to update firmware
> minimum security revision value.

devlink doesn't have a suitable security model. I don't think we should
be adding hacks since we're not security experts and standards like SPDM
exist.

I understand that customers ask for this but "security" is not a
checkbox, the whole certificate and version management is necessary.

