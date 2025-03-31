Return-Path: <netdev+bounces-178427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B868A76FCD
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 274BF7A2E4F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815F621B199;
	Mon, 31 Mar 2025 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHll5J59"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7111D5174
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454707; cv=none; b=cpVe2MeNCJvkQQNYUCShArK15bI8d5sSSUOtq9Q4uhVXFqDKQuV79q771K22xsabUxnAjvK1jOIRgOvt2tq0E++zM9hRI4b4o4q/w0ZAslOEnvCwE4IixYan+n2xXDpmnmp3fDKQGhR16giCusDA9cRl7fgff2bmNiMnRcDBk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454707; c=relaxed/simple;
	bh=zTGJ1ONZKcBMe+6/Kk70AxW/FosCixxLTaX5XnRaPTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErMKnubGtDJizG/PiuwO3HH/sV/iACfED4tY7671bmQkVWwzVlspOW0r4ASE7myqJdZUDgGv0PPBMds0trQUgcYXTdElm88ZJU2ItZwKzGKn9oHHxYPcOzfPQyYMbc2EmvJ7uz4cJurizSLcs3asJywKn1yxC16qU7rhmewqaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHll5J59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540E4C4CEE3;
	Mon, 31 Mar 2025 20:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454706;
	bh=zTGJ1ONZKcBMe+6/Kk70AxW/FosCixxLTaX5XnRaPTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CHll5J59c80tfLoRjlribD/+EU2mReiMK8FmGY91QoHz9lZ435rvoUO+P2aUzbRz3
	 Djbr008/fGaoSKLWawj2QFkPKbG7kvCF31QSR4fhGnhFiIwwatpT6VtmyP50NZAjUS
	 k7qCSZbJVw6EjW0jBV90Eckibxf+26T/NuO8cbguEd3h9UKBiqthgSGMUhexI3xEec
	 YGp09ViF9koP99w4rJaq9/rlF3KJDNo3hIQvBAWyU833UNgCiq/6ejliyKW2FdalLz
	 5EJLijkRhf1oS5pwKKREL87/WviRJB+QjiJAiRMhGpq8yOETPNH0R2awgJZvzkowOf
	 FuUv1VDq4cyOQ==
Date: Mon, 31 Mar 2025 13:58:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net v4 07/11] docs: net: document netdev notifier
 expectations
Message-ID: <20250331135825.32acfce7@kernel.org>
In-Reply-To: <20250331150603.1906635-8-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
	<20250331150603.1906635-8-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 08:05:59 -0700 Stanislav Fomichev wrote:
> +The following notifiers are running without the lock (so the ops-locked
> +devices need to manually grab the lock if needed):

Not sure about the text in the parenthesis, "the devices" don't "grab
the lock". I mean - drivers don't generally register for notifications
about their own devices. It's whoever registered the notifier that needs
to make sure they take appropriate locks. I think we're fine without
that sentence.

> +* ``NETDEV_UNREGISTER``
> +
> +There are no clear expectations for the remaining notifiers. Notifiers not on
> +the list may run with or without the instance lock, potentially even invoking
> +the same notifier type with and without the lock from different code paths.
> +The goal is to eventually ensure that all (or most, with a few documented
> +exceptions) notifiers run under the instance lock.

Should we add a sentence here along the lines of "Please extend this
documentation whenever you make explicit assumption about lock being
held from a notifier." or is that obvious?

