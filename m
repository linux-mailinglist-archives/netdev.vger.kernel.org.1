Return-Path: <netdev+bounces-63546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC74982DDD5
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 17:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B11F2234F
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5617BC7;
	Mon, 15 Jan 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="bvCaCorh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qrYLs+lO"
X-Original-To: netdev@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0517BC4
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 76752580143;
	Mon, 15 Jan 2024 11:46:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Jan 2024 11:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1705337172; x=1705340772; bh=Mk4lPUaXWzN5fqfpUMU+m
	tKlNWiKjs7t8Qar7tTWT0c=; b=bvCaCorh0Ag62f+wPLIJmT9gafdumSMqkXfwH
	freljHAP5v6bej7skvbjb45AAqrI9dD4yBYDklY4ryOQiI6+MsbdItBqTuRCYY/h
	N0qIjNYxIsaWV7S+ANSv8FoPek3Y4Mt70h60DZwTV25vbR8tTLO5fzLBQDod5+6+
	7QUpeKie6cYcxvByTD3jevokSEGRGbmeAuc1u1GDCuvOaHKuoTIu++ZwbmLtxqw5
	Ub59tRMeWiRWYh3+CGb2xVLzaqqWRJbUzGbs5V2IOecwzgQpDmG+XThNlJGW2hgU
	kP66FDxl1fGugFXRrPwW6RSnxxzCBqA/mRSfU5pUT9qUIIY6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	i14194934.fm3; t=1705337172; x=1705340772; bh=Mk4lPUaXWzN5fqfpUM
	U+mtKlNWiKjs7t8Qar7tTWT0c=; b=qrYLs+lO6fNCBsTZeYDL3+YCTk6fBschNp
	bbXNOv2DxIicxgk/A1SFN9RbwW9FPABKtzUrlVbfIdNMkIV23zokfPUXmrLeANhz
	Wvw8ktHHCfadnQ5CgPjIno8QHelY+RfYpKGnOhmL5pY64S1a1IhbV2TdMmZLE9rx
	nsn2VY7RO3RVjgHqb8UBtT8fhBUkZoKNv2mVuOlK0gRIAyvbktgbpXbW9bMz9Z8e
	i22Kk0spuIKCjAavXhka75gRnOc14Lo6qbAcWQRgdOa6TouqsFT557zsicCjbM6Y
	ujK160vjBBNiUhn+0aid11bKySBcaeNBkvW0ym71w+1uAeZOgIEg==
X-ME-Sender: <xms:VGGlZS7IFUyElgcpwBEj3ugCR8u7C-EWFxBlyZUbIYgU30x8i5OkOg>
    <xme:VGGlZb6rfa2eEFEA-27EuGrafpHCoDQnbqjiLdwXl5nOfRxANWcgIKSWncppoCtmd
    EKn6wuQT7F-WZJ9qcg>
X-ME-Received: <xmr:VGGlZRcsV9WroVkzOtF8arjTZmqxSck5MnIyA5zml970mXRhdYwsTDJJoaPhqyHouyewwiALsfI6-hvM4K5EWBLRiiTNtGUCURb6-6iqlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepsfhuvghnthhi
    nhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvg
    hrnhephfffieeivdeiheegleejtdeuieejlefgffejfeehhefhheffieefgeduhfehiefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhguvg
    esnhgrtggthidruggv
X-ME-Proxy: <xmx:VGGlZfLb0QOFRmN9Dr3mbHBLrv_-DzJtXptihkxbG85nEO5lPfW1DA>
    <xmx:VGGlZWLWUQfdJtCZZiXdiORL-WQtSxyBaxJotBLlCD_hYxbAkQ5o1Q>
    <xmx:VGGlZQzwssP-GbrYySWHZRQnJ69yCMfMsJX8H9VnrfmTobvRlqQXBg>
    <xmx:VGGlZS3LjGj-gvt-mlWCbaGSgVWHvdEQ406jwRY5D6RmizcfH5hLOQ>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 11:46:11 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>,
	kernel-team@meta.com
Subject: [RFC iproute2 v5 0/3] ss: pretty-printing BPF socket-local storage
Date: Mon, 15 Jan 2024 17:46:02 +0100
Message-ID: <20240115164605.377690-1-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF allows programs to store socket-specific data using
BPF_MAP_TYPE_SK_STORAGE maps. The data is attached to the socket itself,
and Martin added INET_DIAG_REQ_SK_BPF_STORAGES, so it can be fetched
using the INET_DIAG mechanism.

Currently, ss doesn't request the socket-local data, this patch aims to
fix this.

The first patch requests the socket-local data for the requested map ID
(--bpf-map-id=) or all the maps (--bpf-maps). It then prints the map_id
in a dedicated column.

Patch #2 uses libbpf and BTF to pretty print the map's content, like
`bpftool map dump` would do.

Patch #3 updates ss' man page to explain new options.

While I think it makes sense for ss to provide the socket-local storage
content for the sockets, it's difficult to conciliate the column-based
output of ss and having readable socket-local data. Hence, the
socket-local data is printed in a readable fashion over multiple lines
under its socket statistics, independently of the column-based approach.

Here is an example of ss' output with --bpf-maps:
[...]
ESTAB                  340116             0 [...]
    map_id: 114 [
        (struct my_sk_storage){
            .field_hh = (char)3,
            (union){
                .a = (int)17,
                .b = (int)17,
            },
        }
    ]

Changed this series to an RFC as the merging window for net-next is
closed.

Changes from v4:
* Fix return code for 2 calls.
* Fix issue when inet_show_netlink() retries a request.
* BPF dump object is created in bpf_map_opts_load_info().
Changes from v3:
* Minor refactoring to reduce number of HAVE_LIBBF usage.
* Update ss' man page.
* btf_dump structure created to print the socket-local data is cached
  in bpf_map_opts. Creation of the btf_dump structure is performed if
  needed, before printing the data.
* If a map can't be pretty-printed, print its ID and a message instead
  of skipping it.
* If show_all=true, send an empty message to the kernel to retrieve all
  the maps (as Martin suggested).
Changes from v2:
* bpf_map_opts_is_enabled is not inline anymore.
* Add more #ifdef HAVE_LIBBPF to prevent compilation error if
  libbpf support is disabled.
* Fix erroneous usage of args instead of _args in vout().
* Add missing btf__free() and close(fd).
Changes from v1:
* Remove the first patch from the series (fix) and submit it separately.
* Remove double allocation of struct rtattr.
* Close BPF map FDs on exit.
* If bpf_map_get_fd_by_id() fails with ENOENT, print an error message
  and continue to the next map ID.
* Fix typo in new command line option documentation.
* Only use bpf_map_info.btf_value_type_id and ignore
  bpf_map_info.btf_vmlinux_value_type_id (unused for socket-local storage).
* Use btf_dump__dump_type_data() instead of manually using BTF to
  pretty-print socket-local storage data. This change alone divides the size
  of the patch series by 2.

Quentin Deslandes (3):
  ss: add support for BPF socket-local storage
  ss: pretty-print BPF socket-local storage
  ss: update man page to document --bpf-maps and --bpf-map-id=

 man/man8/ss.8 |   6 +
 misc/ss.c     | 392 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 389 insertions(+), 9 deletions(-)

--
2.43.0


