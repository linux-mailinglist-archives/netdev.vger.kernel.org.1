Return-Path: <netdev+bounces-186422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F0A9F0D1
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDAB188E343
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A11C3314;
	Mon, 28 Apr 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQWAJOgp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91EF9D9
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843615; cv=none; b=rSjlvLi18vzvyzxlUOvw5dXBjyyu5fxa7sBU0XOf9cyRIFF2PmrMOhL0vXnhGdzLw2/H2QbIqT9zcrx8Py0yXmnU0T/RA+bnM7xnOCuk2asGPyDL43bxyBBrkHPWV7ex/iiZY92V52BjZQKrNCzUCy1/shE4hpcp33DnyayzpAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843615; c=relaxed/simple;
	bh=NK075ENHNhUJrW27229t/0d/QEnab2iq899nQmXW6HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3NvIkgI1s5YGPCCpOJ4QnGyWcYAftwhbv+uTr2c8Jm9hinKGasCkg8edUcsLs12/mmx+vbzNbrDRKf9i/1gRvDYl/51at31jJlg0nrZ0UYAUKg9o1uTggdpokco3+XDZYp6dJQN86JkFJq5rtWQ2VtfO2Dtetx00wHawSnVbT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQWAJOgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE23C4CEE4;
	Mon, 28 Apr 2025 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745843614;
	bh=NK075ENHNhUJrW27229t/0d/QEnab2iq899nQmXW6HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQWAJOgp+AFN6OBD2sbMhpU54Pdw2wn8/aZMsd8STXYRZWutXdQDHXVn1krOorLZE
	 4YuJf9d5TL9AI6eFa8g0nOcCy5HOBPILRLH0mfESIsRBHqzwOgB8VUlv2bdGFHIvqI
	 0GES1ycgF4Ok3wkk7q8y1I49UmidIup61lbNBq/RlNzrQjhwAK+oqgzLSYyW63x0Wo
	 3kjrN1hE/XaZunUhzri4l9ibnWH/Xs13xpTLUpCfHFtztt/6CACmzCrLbgUlY6nBNs
	 Kv89oJv8u4cEFYivdrLkSjpeS63je+Z4cQarYieWDhFXgDs3uF3NjcGEvlxDE4JYfO
	 DM/HjskYhB6Cg==
Date: Mon, 28 Apr 2025 13:33:29 +0100
From: Simon Horman <horms@kernel.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Avihai Horon <avihaih@nvidia.com>
Subject: Re: [RFC net-next 1/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <20250428123329.GA3339421@horms.kernel.org>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
 <1745416242-1162653-2-git-send-email-moshe@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1745416242-1162653-2-git-send-email-moshe@nvidia.com>

On Wed, Apr 23, 2025 at 04:50:38PM +0300, Moshe Shemesh wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> A function unique identifier (UID) is a vendor defined string of
> arbitrary length that universally identifies a function. The function
> UID can be reported via devlink dev info.
> 
> Add UID attribute to devlink port function that reports the UID of the
> function that pertains to the devlink port.
> 
> This can be used to unambiguously map between a function and the devlink
> port that manages it, and vice versa.
> 
> Example output:
> 
> $ devlink port show pci/0000:03:00.0/327680 -jp
> {
>     "port": {
>         "pci/0000:03:00.0/327680": {
>             "type": "eth",
>             "netdev": "pf0hpf",
>             "flavour": "pcipf",
>             "controller": 1,
>             "pfnum": 0,
>             "external": true,
>             "splittable": false,
>             "function": {
>                 "hw_addr": "5c:25:73:37:70:5a",
>                 "roce": "enable",
>                 "max_io_eqs": 120,
>                 "uid": "C6A76AD20605BE026D23C14E70B90704F4A5F5B3F304D83B37000732BF861D48MLNXS0D0F0"
>             }
>         }
>     }
> }
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  Documentation/netlink/specs/devlink.yaml      |  3 ++
>  .../networking/devlink/devlink-port.rst       | 12 +++++++
>  include/net/devlink.h                         |  8 +++++
>  include/uapi/linux/devlink.h                  |  1 +
>  net/devlink/port.c                            | 32 +++++++++++++++++++
>  5 files changed, 56 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index bd9726269b4f..f4dade0e3c70 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -894,6 +894,9 @@ attribute-sets:
>          type: bitfield32
>          enum: port-fn-attr-cap
>          enum-as-flags: True
> +      -
> +       name: uid
> +       type: string
>  
>    -
>      name: dl-dpipe-tables

Hi Avihai,

With this patch, after running tools/net/ynl/ynl-regen.sh -f, I see the
following when I run git diff. So I think this patch needs these changes
too.

diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f..1dc90bde8 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -11,11 +11,12 @@
 #include <uapi/linux/devlink.h>

 /* Common nested types */
-const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
+const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_UID + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
 	[DEVLINK_PORT_FN_ATTR_STATE] = NLA_POLICY_MAX(NLA_U8, 1),
 	[DEVLINK_PORT_FN_ATTR_OPSTATE] = NLA_POLICY_MAX(NLA_U8, 1),
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
+	[DEVLINK_PORT_FN_ATTR_UID] = { .type = NLA_NUL_STRING, },
 };

 const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 8f2bd50dd..3a12c18c6 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -12,7 +12,7 @@
 #include <uapi/linux/devlink.h>

 /* Common nested types */
-extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
+extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_UID + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];

 /* Ops table for devlink */

...

