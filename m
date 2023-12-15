Return-Path: <netdev+bounces-57825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3600681449D
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03411F2368F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41121803F;
	Fri, 15 Dec 2023 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC6XwFps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B819449;
	Fri, 15 Dec 2023 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c580ba223so5620265e9.3;
        Fri, 15 Dec 2023 01:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633052; x=1703237852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YP8/WdIHo639hX868zrUj3464zsIGDGk/+hlXcKNLgE=;
        b=JC6XwFpsJMr3ojBXCO0a1SC6E0qbgWpA7twtzP33qlyHw1DYxSzdpuOZW70w4x/mgP
         azV9stJ9H3EVLTEjrz+DHK3YdRNExXNjkp/Vg0sL9LDPLSFuID80x9Ge0JjdIOnikvrK
         fVMjweBpjMJhOJjPgLDTXhufebbATC0olkULwn+FVIJWsIOscAv5Wlr+0gHMiciE8vnY
         T9auGxsc9g43f1ZDQVwTF+Lza4e+LE89USQbISRbaK81UBqarCrX9gvNliCeDhIIbayF
         H1UJXO/eQWi+dN++vi1QibgoxZXBANG29g3AGwPBiMzofVycLgbSuQ8G5OD7xjQ8lEKt
         239g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633052; x=1703237852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YP8/WdIHo639hX868zrUj3464zsIGDGk/+hlXcKNLgE=;
        b=T28iEgQq6noKzsnU0IcFtJOECUOcLrUFTiVBrR49vNf+nMTt+xle7BWSrfqdzfpGhb
         nXqvJKV2/cQvDDFnG2xjVfqKJFH22OwwwKgvJojVWoH3AkIsaslPHJ7UIuTll4CarHkO
         6+lNCFPVIuii1+fiFHrwWiceCqM0UaJrU7TQ0lkXhu9mOiykygqiJCCYjvsWqZiZQkO8
         dOKnp5aB8sQBuerBHW3upgwzy3p5ddI1GTz+5NVhj3n8YyGVMI31ngcTLu6LfP1jqW1d
         tZjRMUQrxgHrh2SswnBlK/T+VKrSzy4PEch6fXwwsKj59Gnk0uSzEYdTzL+iXvAIk/yc
         XjsQ==
X-Gm-Message-State: AOJu0YzID/LZDqeBBuQsqcwici6VCE6tm6gJRkQSHnls+NVwH8IKHVU4
	rHxzKUMBrzoyyDGTiCWvoIbioWNm30ayhg==
X-Google-Smtp-Source: AGHT+IF+Jzxwwxye0zYw7npR/zN5tOHZmN/+VdbwphgtGyFhEnxJ4dJsxMfHupZJW4mROyU5GKLZkA==
X-Received: by 2002:a05:600c:5249:b0:40c:6b94:4804 with SMTP id fc9-20020a05600c524900b0040c6b944804mr266974wmb.158.1702633051485;
        Fri, 15 Dec 2023 01:37:31 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:30 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v5 00/13] tools/net/ynl: Add 'sub-message' support to ynl
Date: Fri, 15 Dec 2023 09:37:07 +0000
Message-ID: <20231215093720.18774-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a 'sub-message' attribute type to the netlink-raw
schema and implements it in ynl. This provides support for kind-specific
options attributes as used in rt_link and tc raw netlink families.

A description of the new 'sub-message' attribute type and the
corresponding sub-message definitions is provided in patch 3.

The patchset includes updates to the rt_link spec and a new tc spec that
make use of the new 'sub-message' attribute type.

As mentioned in patch 4, encode support is not yet implemented in ynl
and support for sub-message selectors at a different nest level from the
key attribute is not yet supported. I plan to work on these in follow-up
patches.

Patches 1 is code cleanup in ynl
Patches 2-4 add sub-message support to the schema and ynl with
documentation updates.
Patch 5 adds binary and pad support to structs in netlink-raw.
Patches 6-8 contain specs that use the sub-message attribute type.
Patches 9-13 update ynl-gen-rst and its make target

Changes since v4:
 - Update tc spec to remove fixed header attributes from ops

Changes since v3: (reported by Breno Leitao)
 - Remove an unnecessary make dependency from the YNL_INDEX target.

Changes since v2: (reported by Jakub Kicinski and Breno Leitao)
 - Fixed ynl-gen-c breakage
 - Added schema constraint for pad/binary & len
 - Improved description text in raw schema
 - Used | for all multi-line text in schema
 - Updated docs with explanation of what a sub-message is
 - Reverted change in ynl-gen-rst
 - Added ynl-gen-rst patches and grouped them all at end of patchset

Changes since v1: (reported by Jakub Kicinski, thanks!)
 - Added cleanups for ynl and generated netlink docs
 - Describe sub-messages in netlink docs
 - Cleaned up unintended indent changes
 - Cleaned up rt-link sub-message definitions
 - Cleaned up array index expressions to follow python style
 - Added sub-messages to generated netlink spec docs

Donald Hunter (13):
  tools/net/ynl: Use consistent array index expression formatting
  doc/netlink: Add sub-message support to netlink-raw
  doc/netlink: Document the sub-message format for netlink-raw
  tools/net/ynl: Add 'sub-message' attribute decoding to ynl
  tools/net/ynl: Add binary and pad support to structs for tc
  doc/netlink/specs: Add sub-message type to rt_link family
  doc/netlink/specs: use pad in structs in rt_link
  doc/netlink/specs: Add a spec for tc
  doc/netlink: Regenerate netlink .rst files if ynl-gen-rst changes
  tools/net/ynl-gen-rst: Add sub-messages to generated docs
  tools/net/ynl-gen-rst: Sort the index of generated netlink specs
  tools/net/ynl-gen-rst: Remove bold from attribute-set headings
  tools/net/ynl-gen-rst: Remove extra indentation from generated docs

 Documentation/Makefile                        |    6 +-
 Documentation/netlink/netlink-raw.yaml        |   65 +-
 Documentation/netlink/specs/rt_link.yaml      |  449 +++-
 Documentation/netlink/specs/tc.yaml           | 2031 +++++++++++++++++
 .../userspace-api/netlink/netlink-raw.rst     |   96 +-
 tools/net/ynl/lib/nlspec.py                   |   55 +
 tools/net/ynl/lib/ynl.py                      |   94 +-
 tools/net/ynl/ynl-gen-rst.py                  |   31 +-
 8 files changed, 2782 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/netlink/specs/tc.yaml

-- 
2.42.0


