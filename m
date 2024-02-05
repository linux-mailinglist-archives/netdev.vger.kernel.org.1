Return-Path: <netdev+bounces-69048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B48496E1
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 10:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FB41C21625
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0236612B82;
	Mon,  5 Feb 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="k5HuoGjw"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26277134A5
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126294; cv=none; b=FVnofQxOArZPaQvpDhHrt/bLKjyYCJpIRjM8kivpMfwB5mOnd3QQBtptjLziJmcydGMe3oVOFHIEndbbmidQdItza3Fp/tCiQGqy5cee0f2Tx+g8yTqR5Yeb9cZTb+RhWY5L2leQq/3TFbl0E+sJw1fZNHokYdT9y21LOZPJ/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126294; c=relaxed/simple;
	bh=gFMBNJGu9VZEDhSYeYkfG1jDiEkrRtpqKC8d0aEuV2U=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Y7UkkXU1V6RKgy8WWBM9nn5O0EgNXr9cDWD8rxI/rsZ+qJ1MJjVD1jC+jpi28L5XsTvntzynjoNCa1ZAceVYrgorfygO6X1Sfc5ltbq33X4Tnhe91T2Eqkn1Q0rTvASnPX9WIePLUHK1TwnQBgObVImr+vQS/YxUJYU2zEiWqwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org; spf=pass smtp.mailfrom=pmachata.org; dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b=k5HuoGjw; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TT1gY3vfkz9shb;
	Mon,  5 Feb 2024 10:44:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1707126281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFMBNJGu9VZEDhSYeYkfG1jDiEkrRtpqKC8d0aEuV2U=;
	b=k5HuoGjwsl3VeI4hBKLcym9DepGBsxOqFRMwSYyM31CGgnLJl9pZnmYINiYuMVrqVIOENr
	qUEWRsLzQOV0wN5zig71Glm2BiYP3RmLn/POxwwBm9NDTkpw7PHT3/D3vVAvl6MtQUdzGh
	mg0Sue56F6ap/JmFjL5ThUBM9fXb4G+ph1PTx+QnJBo30tspdZ9/A/qKzqdVxzAVqa9lfo
	GEz7I3wvAv88BP47YsBseXFW/2BrUX45CSDrCl0wIJqtanepYFagZOsKThq+GuchG0OsMz
	61r72dgEmQ+YQQnfs4LUWLsladNrZ7LgZrJ490SK7kArN9MtzkCJT4FSOI/ngg==
References: <20240203200305.697-1-yedaya.ka@gmail.com>
From: Petr Machata <me@pmachata.org>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Stephen
 Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] ip: Add missing stats command to usage
Date: Mon, 05 Feb 2024 10:44:16 +0100
In-reply-to: <20240203200305.697-1-yedaya.ka@gmail.com>
Message-ID: <87plxbjldk.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Yedaya Katsman <yedaya.ka@gmail.com> writes:

> The stats command was added in 54d82b0699a0 ("ip: Add a new family of
> commands, "stats""), but wasn't included in the subcommand list in the
> help usage.
> Add it in the right position alphabetically.
>
> Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>

Reviewed-by: Petr Machata <me@pmachata.org>

