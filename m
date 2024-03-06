Return-Path: <netdev+bounces-78067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DEA873FB7
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B227128241E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA87113E7D7;
	Wed,  6 Mar 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFDcygQG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD912CDBC
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749876; cv=none; b=hpYPms2DxS4M+dBswbZv4Rk07mnKCRncLgxv+xqClc4w/XyECW6RE2JmqJrb03JCZhxDZHP8Q4VpnCRtOQtH/zikeE1xU2/NTEDjVdYT+yoC6+s67Tbeh+dtbK/WEiavZHmjs17G3O8sW9D/lSNb/BfPdTlyskqFYB9/DcXMkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749876; c=relaxed/simple;
	bh=6XZ2BDBnke2gcWVkzc6vKy+5Ms84zjfkxwn4foU9h5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN12C9I0ok8PuH1IDCS2h3qown2ss7hyFOQBNtUtz7sCrZ6s102sTfDjMw0XWKlgf61toCP6QoLt/pMzWZxXe2TiYNHpXwGKQ0QKowCm4ei6kXy5hoBvVDPUMjSMnytOENIyaqL0qTFEmwZgtrkIM0OEhlds/i8u82OiunCTMl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFDcygQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF76C433F1;
	Wed,  6 Mar 2024 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709749876;
	bh=6XZ2BDBnke2gcWVkzc6vKy+5Ms84zjfkxwn4foU9h5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lFDcygQGuGovbQkbpn9HiR5v7R1P0vTEyVPsY+poaLUuhn/Lx18FqUXovBvfNyjPY
	 z09Pn6ksoPGf8bEU36f0P+LAxLfKN7yEb/Y9MLrGzO9Fmel1JUkxQikEibCKhTlvu6
	 +4aRnofNWZ3mbpe5Bdtt+RgeBP2Nkndhc7ViVwbFfvmALnD5umAPDPvCLUssVHqZTl
	 N/LJYIXfdHH+tBIadDXzdPrNlRd3NvbKLGquJODLOTnnwTD4BzWL8aiz23YFPzhgbB
	 D2QAt4ZgFJR8BOFUbtWAZFiSHlwFDCAGPlIjXitn+KY7HM9VZnIHqvRZ6KrM9r3b/O
	 NPsY7hjFlb6GQ==
Date: Wed, 6 Mar 2024 10:31:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 5/5] doc/netlink/specs: Add spec for nlctrl
 netlink family
Message-ID: <20240306103114.41a1cfb4@kernel.org>
In-Reply-To: <20240306125704.63934-6-donald.hunter@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
	<20240306125704.63934-6-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 12:57:04 +0000 Donald Hunter wrote:
> diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
> new file mode 100644
> index 000000000000..2e55e61aea11
> --- /dev/null
> +++ b/Documentation/netlink/specs/nlctrl.yaml
> @@ -0,0 +1,206 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +
> +name: nlctrl
> +protocol: genetlink-legacy
> +uapi-header: linux/genetlink.h
> +
> +doc: |
> +  Genetlink control.

How about:

  genetlink meta-family, exposes information about all
  genetlink families registered in the kernel (including itself).

> +definitions:
> +  -
> +    name: op-flags
> +    type: flags
> +    enum-name: ''

I've used
	enum-name:
i.e. empty value in other places.
Is using empty string more idiomatic?
Unnamed enums are kinda special in my mind, because we will use normal
integer types to store the values in code gen.

> +    entries:
> +      - admin-perm
> +      - cmd-cap-do
> +      - cmd-cap-dump
> +      - cmd-cap-haspol
> +      - uns-admin-perm
> +  -
> +    name: attr-type
> +    enum-name: netlink_attribute_type

s/_/-/
The codegen will convert them back

> +    type: enum
> +    entries:
> +      - invalid
> +      - flag
> +      - u8
> +      - u16
> +      - u32
> +      - u64
> +      - s8
> +      - s16
> +      - s32
> +      - s64
> +      - binary
> +      - string
> +      - nul-string
> +      - nested
> +      - nested-array
> +      - bitfield32
> +      - sint
> +      - uint
> +
> +attribute-sets:
> +  -
> +    name: ctrl-attrs
> +    name-prefix: CTRL_ATTR_

also: s/_/-/ and lower case, code-gen will take care of the exact
formatting.

With those nits:

Acked-by: Jakub Kicinski <kuba@kernel.org>

I haven't checked the exact formatting, but off the top of my head 
the contents look good :)

