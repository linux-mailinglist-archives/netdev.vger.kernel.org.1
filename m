Return-Path: <netdev+bounces-109686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 421359298E6
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A641F21522
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04992BD1E;
	Sun,  7 Jul 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJuz1bt/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61B45BE4
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720370906; cv=none; b=RtZx074S8GNuzMzw+ah0+eejQHwu4BZVuzebKBRE7WdVzsqqeNv5n+N7brd7PC0f6fKj1It5/vhv1xbNZxrF3SMeGRQnYMQThBDJUnal07uk6xDCHw+WTMRyBeQ9BYBE98KpOViys5zolXMoQItErC66wsP59CYBp96HVHokOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720370906; c=relaxed/simple;
	bh=vXA7jwWTOvr54NS5A9GaL72g8miWOmXrGOQWIvnMtmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1kdIkoCpLGE8bdFhabPkaSxQK2CP8DzRrWlnXvZ7JD6CQu+F9IXDxaE8dHZHRTotDPJgvDGhfFCSUpjmG3qiEoiEZ2PA59j3n3IKL3nKC8FjMxyYTBT5awlxQNsZK/vxihJyrK6MN8Q8MzIWjDphGMqJuQXW6RgyJSKdSLuzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJuz1bt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1D6C32781;
	Sun,  7 Jul 2024 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720370905;
	bh=vXA7jwWTOvr54NS5A9GaL72g8miWOmXrGOQWIvnMtmo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZJuz1bt/CsFlut27+EbZVNfHdvCvry9GIlWUb82HNVjXjUarhl+LofNtTjxEBQN8l
	 v/anTCpNOEnkGeWhaEl1lPUGTt1x/v3Qz5tr6wDu8cX5V0QC3RDA+fWsQKvTiDyByO
	 IAif1Ffa1ziaahfZLAkbZ6rjV2LxVJrmykx5ya0qiADcaoVJwZzD7x8b3USxVJVppi
	 N2b42/gmcilnXvsX50ulJBPSF/ZSVdw42av5pGbUe/45sa3mJe3G29PYZlPqZos8hU
	 71ABobmZHsb/K3ssLKbP/hGlU4kX0haHchIPa05ChfS9g1O6LpGSSwWSuZIJovu55/
	 5nixNOSo0qXJw==
Message-ID: <59086858-c144-4246-9692-8b4f9d9b4284@kernel.org>
Date: Sun, 7 Jul 2024 10:48:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 3/3] Makefile: support building from
 subdirectories
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>
References: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
 <20240703131521.60284-4-przemyslaw.kitszel@intel.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240703131521.60284-4-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/24 7:15 AM, Przemek Kitszel wrote:
> Support building also from subdirectories, like: `make -C devlink` or
> `cd devlink; make`.
> 
> Extract common defines and include flags to a new file (common.mk) which
> will be included from subdir makefiles via the generated config.mk file.
> 
> Note that the current, toplevel-issued, `make` still works as before.
> Note that `./configure && make` is still required once after the fresh
> checkout.
> 

That is a very disruptive requirement - e.g., someone running git bisect.

Even after a configure, I get build failures:

    LINK     rtmon
/usr/bin/ld: ../lib/libutil.a(utils.o): in function `drop_cap':
utils.c:(.text+0x2c6a): undefined reference to `cap_get_proc'
/usr/bin/ld: utils.c:(.text+0x2c89): undefined reference to `cap_get_flag'
/usr/bin/ld: utils.c:(.text+0x2c9d): undefined reference to `cap_clear'
/usr/bin/ld: utils.c:(.text+0x2ca9): undefined reference to `cap_set_proc'
/usr/bin/ld: utils.c:(.text+0x2cb5): undefined reference to `cap_free'
/usr/bin/ld: ../lib/libnetlink.a(libnetlink.o): in function `err_attr_cb':
libnetlink.c:(.text+0x1a): undefined reference to `mnl_attr_type_valid'
/usr/bin/ld: libnetlink.c:(.text+0x26): undefined reference to
`mnl_attr_get_type'
/usr/bin/ld: libnetlink.c:(.text+0x40): undefined reference to
`mnl_attr_validate'
/usr/bin/ld: ../lib/libnetlink.a(libnetlink.o): in function
`nl_dump_ext_ack':
libnetlink.c:(.text+0x2f5): undefined reference to `mnl_nlmsg_get_payload'
/usr/bin/ld: libnetlink.c:(.text+0x323): undefined reference to
`mnl_attr_parse'
/usr/bin/ld: libnetlink.c:(.text+0x366): undefined reference to
`mnl_attr_get_str'
/usr/bin/ld: libnetlink.c:(.text+0x37e): undefined reference to
`mnl_attr_get_u32'
/usr/bin/ld: libnetlink.c:(.text+0x3a7): undefined reference to
`mnl_attr_get_u32'
/usr/bin/ld: libnetlink.c:(.text+0x3e5): undefined reference to
`mnl_nlmsg_get_payload_len'
/usr/bin/ld: ../lib/libnetlink.a(libnetlink.o): in function
`nl_dump_ext_ack_done':
libnetlink.c:(.text+0x8e4): undefined reference to `mnl_attr_parse'
/usr/bin/ld: libnetlink.c:(.text+0x8f8): undefined reference to
`mnl_attr_get_str'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:32: rtmon] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:36: all] Error 2

