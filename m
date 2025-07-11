Return-Path: <netdev+bounces-206278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E21B02746
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A81B17A980
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 22:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCBE215179;
	Fri, 11 Jul 2025 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEAj4Xq2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B41A3145
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274720; cv=none; b=o0Ab5tMVhmdL+bUF/uTGgWEr/eFHHChwKI/1oXnMMl7Nk3P1eBiLn1boFOTL16CFdWDRFz8pVC03+8YW+a99hAAusG9IAy43GY8MCljtoDSeEJDauPLNi9jVpE7v+lI+Ynmpyu5vhSpwPJc6PfTrt0cj8lV58X9DJtnrfNT/JlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274720; c=relaxed/simple;
	bh=HKYW+no66acqZma8IrAwntl/cWh3Z0y7dyzQZzCJxEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyFjFEf5R7/Lr2baIHAJGZSzadgcdLRA2bZ/8a1dtgfEcqXFOhylfmbymxvC0rO5rwLJdEZ8dCWxp66pBaQKalyKaWSjTLWXng10RQ3Gs7jTASsZ8ofpENR8bczW4S81PQA3E1VE2Nr/BA5tVolh2VhtxffxyOhXLP2DTlQAx2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEAj4Xq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57155C4CEED;
	Fri, 11 Jul 2025 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752274719;
	bh=HKYW+no66acqZma8IrAwntl/cWh3Z0y7dyzQZzCJxEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EEAj4Xq2Lq+yjQZCkFCYmt+MdAMq0UucFmPiBfQ63HXKDYhz9BRA9KWwQDC4r+wwx
	 EJHbVQ3dZAvYXu5zGzjZhnYECfWSQwafs2VE84HLZLnaorWX1t8GksRV4QaFLEy8wp
	 5jMO152KCAdIqDBLUV5NptiWekWIYpmtG4bhXPqbaP+cPOqjm480OT8TreQ7WeTb2N
	 3joOXRbb1WdzMSK0zQoxTrmdZiOd7U0bPiExoe6G+Vls7StfeO9ExONBsdAcREgjck
	 TEFnkwfKTb6VoXuco5aXE/sXZiocJlne4Lu4OK9APpjBTTdHYJL9McMG9kqGpHtORC
	 HIZ5Jk3Js/pPA==
Date: Fri, 11 Jul 2025 15:58:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>, Arkadiusz
 Kubalewski <arkadiusz.kubalewski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1] tools: ynl: process unknown for enum values
Message-ID: <20250711155838.6866a64c@kernel.org>
In-Reply-To: <20250711170456.4336-1-donald.hunter@gmail.com>
References: <20250711170456.4336-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 18:04:56 +0100 Donald Hunter wrote:
> Extend the process_unknown handing to enum values and flags.
> 
> Tested by removing entries from rt-link.yaml and rt-neigh.yaml:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

