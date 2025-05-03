Return-Path: <netdev+bounces-187575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEBFAA7DF6
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 03:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555AC3A4F70
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7722DDD2;
	Sat,  3 May 2025 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stfRzFe8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8D17F7
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746236766; cv=none; b=sCUhMrkMQSPuGzPvmsfVlEAi0zzSqhdJfZN5UuX7CjlZ8IB7ZYZ0XdGXm966Mwi6xU2RmKySOkPJW/wBcI9leNHF25xiO/g9tyGrXsIH1raOgjHpMw02rXuakz/c0OUo173kTTiSwLe9K3/qLGCw3IkyflnC06LsjHJPfUCbYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746236766; c=relaxed/simple;
	bh=tddhTwwsTKoLq9gpV7I8JWynZV5jt/lhOb10LeB50Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqPMgLhJuVrVfCniIXzrGG9gqHmEZ98p8Fzf0lP+wTJsaWDFLiEV/eLi2bmPGmiTmjemRJ95V8d9r8He4jJPjtmwvI108fLr/u4qvzKWNq6qdNAAr4Fo5bmrp1T0Ii6dPMyr1Kg25XqQB8qUhNinP3UgGttBlskm27P4XWsd6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stfRzFe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80FEC4CEE4;
	Sat,  3 May 2025 01:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746236765;
	bh=tddhTwwsTKoLq9gpV7I8JWynZV5jt/lhOb10LeB50Hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=stfRzFe8sl9RVASnO5ilz2hJOZzGmPxsgQVMAczMq055lo0v7cRrDQUY/rsZifWNK
	 owO2bEhMoXSKIQMlKyl/87tMSvL0ur14rHCLw9NPJ7T1ycuy/OzLaRiC3haPwMoW2n
	 QKcqqq3EBnwtRhfDmNo5v65CkCmD7/BNeV9qZ+BxeePfMaeG0ggaHbFEW9oRppVOzB
	 Rnp80fi3V93xc/QKvBYdgeQtvxNURAcVl4kz9KzQdj8BQSToSpSKGCrjW6cnLiDImO
	 /JkQD6jXIsG0ayYyOwRVeeT09KRzZVZCEanmK2PjoDqL/txW4tA8+VF0pt4MycCd4N
	 knnbEEsYGiG8Q==
Date: Fri, 2 May 2025 18:46:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, horms@kernel.org,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next 3/5] devlink: define enum for attr types of
 dynamic attributes
Message-ID: <20250502184604.1758c65e@kernel.org>
In-Reply-To: <20250502113821.889-4-jiri@resnulli.us>
References: <20250502113821.889-1-jiri@resnulli.us>
	<20250502113821.889-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 May 2025 13:38:19 +0200 Jiri Pirko wrote:
> +/**
> + * enum devlink_var_attr_type - Variable attribute type.
> + */

If we want this to be a kdoc it needs to document all values.
Same as a struct kdoc needs to document all values.
Not sure if there's much to say here for each value, so a non-kdoc
comment is probably better?

I think I already mentioned this generates a build warning..

> +enum devlink_var_attr_type {
> +	/* Following values relate to the internal NLA_* values */
> +	DEVLINK_VAR_ATTR_TYPE_U8 = 1,
> +	DEVLINK_VAR_ATTR_TYPE_U16,
> +	DEVLINK_VAR_ATTR_TYPE_U32,
> +	DEVLINK_VAR_ATTR_TYPE_U64,
> +	DEVLINK_VAR_ATTR_TYPE_STRING,
> +	DEVLINK_VAR_ATTR_TYPE_FLAG,
> +	DEVLINK_VAR_ATTR_TYPE_NUL_STRING = 10,
> +	DEVLINK_VAR_ATTR_TYPE_BINARY,
> +	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
> +	/* Any possible custom types, unrelated to NLA_* values go below */
> +};

