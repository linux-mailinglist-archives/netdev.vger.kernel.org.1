Return-Path: <netdev+bounces-42401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C27CE978
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 22:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCBB1C20BA4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC44F1EB55;
	Wed, 18 Oct 2023 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dqahTBii"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5EF134BF
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 20:58:18 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3097FA
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 13:58:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405497850dbso68118475e9.0
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697662694; x=1698267494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGehmYN8Ky9/qdFKGljwOvuW+bvnZbHPSI7WueW+eeI=;
        b=dqahTBiibTygGNpA4nmG9R7uMrkk1KTWppoGv4Z/+eK9p0dS3hPLRNm+xO57HwpU1t
         A8mzrRdDypU5C0HHHdDy4NMNsL8nILe/u+e0pyZ1jB8Q9ekNbiUvro2/OR9VZVvmkAeW
         cVWzkdf5gXorczZGvuMSuksCD3IVtOWNZ6r+zIJr8GoCatgoxmRunjesDzKXHb0A25Go
         uc2OFUwO/mXlC9QwQx6DoNfoIgUU12ODmF8I6e+8KPcBIItpVXPzm4T27xFa/5HZj3Y3
         7Ygmnoh/8zRojQFxLsB95QeXTuXWSY+DeyvqgtdyJ8mXrsjdk9fGD/b3AJawSlyKEXVL
         JJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662694; x=1698267494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGehmYN8Ky9/qdFKGljwOvuW+bvnZbHPSI7WueW+eeI=;
        b=vOrbE9I0n0Mf0ujhRyelXyxerhWLjTrghTsix5CX4yRB1BhGBZgVCdlpBRUvhk7eMS
         fPtIZvVuqRmAnz7SmyMQUv02rP9APWB/kam+H97zak4Gcsb9KsI/NfBEoynVhEdGWIaU
         NDkQc7/CkZnHX0I69hgcwSGmOiJkA1+lGdXlgsLp0uXiVZxj/m3b07E++YstGGSxtT+U
         X5LdcbbvxWAIc7Z083UZ7Q204c4cMoZ7yJrSm8U7rWExnNcUE+CnpN/7tBVizooLIVvS
         GW5Q7p3Yhz9XeZpzz2VWJ2SUfSoKVFJY2PlC7ims5Iiz2xpaab4BGEhJAyufo/o46g/w
         o9qw==
X-Gm-Message-State: AOJu0YzD91JLiPw+jaIOLb15D1ok6RgGLXSg5xAbrQsw8QXE7E1NOxyj
	Zz//xKNO66aBGi5gRiEbAkSX6A==
X-Google-Smtp-Source: AGHT+IG60tbaNUvk1jN5vD1KFbEiMcP6M0PQBK1rS5pG6qb1LHSMiub03bai6DdYhZHjL5WpNkKbJA==
X-Received: by 2002:a05:600c:4714:b0:405:3d41:5646 with SMTP id v20-20020a05600c471400b004053d415646mr408301wmo.2.1697662694320;
        Wed, 18 Oct 2023 13:58:14 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a05600c421300b003fc16ee2864sm2569006wmh.48.2023.10.18.13.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:58:13 -0700 (PDT)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Bob Gilligan <gilligan@arista.com>,
	Dan Carpenter <error27@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Donald Cassidy <dcassidy@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	"Gaillardetz, Dominik" <dgaillar@ciena.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ivan Delalande <colona@arista.com>,
	Leonard Crestez <cdleonard@gmail.com>,
	"Nassiri, Mohammad" <mnassiri@ciena.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <horms@kernel.org>,
	"Tetreault, Francois" <ftetreau@ciena.com>,
	netdev@vger.kernel.org,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v15 net-next 00/23] net/tcp: Add TCP-AO support
Date: Wed, 18 Oct 2023 21:57:14 +0100
Message-ID: <20231018205806.322831-1-dima@arista.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is version 15 of TCP-AO support. It addresses Eric's review
comments (thanks!) and fixes the issue reported by kernel test
robot (by Oliver). Other than that, selftests refactoring changes.

There's one Sparse warning introduced by tcp_sigpool_start():
__cond_acquires() seems to currently being broken. I've described
the reasoning for it on v9 cover letter. Also, checkpatch.pl warnings
were addressed, but yet I've left the ones that are more personal
preferences (i.e. 80 columns limit). Please, ping me if you have
a strong feeling about one of them.

The following changes since commit c4eee56e14fe001e1cff54f0b438a5e2d0dd7454:

  net: skb_find_text: Ignore patterns extending past 'to' (2023-10-18 11:09:55 +0100)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-v15

for you to fetch changes up to 70168f1d401f70f0a952f9738f62e45acba6ae9f:

  Documentation/tcp: Add TCP-AO documentation (2023-10-18 20:53:16 +0100)

----------------------------------------------------------------

And another branch with selftests, that will be sent later separately:

  git@github.com:0x7f454c46/linux.git tcp-ao-v15-with-selftests

Thanks for your time and reviews,
         Dmitry

--- Changelog ---

Changes from v14:
- selftests: Refactored (enum test_fault) into tcp_ao selftest's lib/
- selftests: Refactored should_skip_test(), TEST_NEEDS_MD5,
  TEST_NEEDS_VRF, check_*_support() into lib/kconfig.c
- selftests: checked that tests are properly SKIPed when kernel config
  doesn't have required options enabled: net_ns, veth, tcp_ao and
  optionally tcp_md5, net_vrf
- Corrected Simon's email as his corigine address bounces back
- Fix missed ifdeffery for rcu_read_lock() in tcp_v6_send_reset()
  (kernel test robot <oliver.sang@intel.com>)
- Move tcp_key::sne after tcp_key::traffic_key to avoid a hole (Eric)
- In patch that wires up RST packets move TCPF_TIME_WAIT sk_state check
  to (TCPF_LISTEN | TCPF_NEW_SYN_RECV) checks in
  tcp_ao_prepare_reset(). (Eric)
- Converted tcp_ao_info::refcnt from atomic_t to refcount_t (Eric)
- Removed TODO comment in tcp_ao_connect_init(): can't happen because of
  the checks in tcp_connect(). Added WARN_ON_ONCE() if anything gets
  broken.

Version 14: https://lore.kernel.org/all/20231009230722.76268-1-dima@arista.com/T/#u

Changes from v13:
- Converted Documentation/ page from human unreadable list-table::
  to grid-table(s) (Jonathan)

Version 13: https://lore.kernel.org/all/20231004223629.166300-1-dima@arista.com/T/#u

Changes from v12:
- Separate TCP-AO sign from __tcp_transmit_skb() into a separate
  function for code locality and readability (Paolo)
- Add TCP-AO self-connect selftest, which by its nature is a selftest
  for TCP simultaneous open, use different keyids and check tcp repair
- Fix simultaneous open: take correct ISNs for verification,
  pre-calculate sending traffic key on SYN-ACK, calculate receiving
  traffic key before going into TCP_ESTABLISHED
- Use kfree_sensitive() for hardening purposes
- Use READ_ONCE() on sk->sk_family when not under socket lock to prevent
  any possible race with IPV6_ADDRFORM

Version 12: https://lore.kernel.org/all/20230918190027.613430-1-dima@arista.com/T/#u

Changes from v11:
- Define (struct tcp_key) for tcp-fast path and detect by type what key
  was used. This also benefits from TCP-MD5/TCP-AO static branches (Eric)
- Remove sk_gso_disable() from TCP-AO fast-path in __tcp_transmit_skb()
  (Eric)
- Don't leak skb on failed kmalloc() in __tcp_transmit_skb() (Eric)
- skb_dst_drop() is not necessary as kfree_skb() calls it (Eric)
- Don't dereference tcp_ao_key in net_warn_ratelimited(), outside of
  rcu_read_lock() (Eric)

Version 11: https://lore.kernel.org/all/20230911210346.301750-1-dima@arista.com/T/#u

Changes from v10:
- Make seq (u32) in tcp_ao_prepare_reset() and declare the argument
  in "net/tcp: Add TCP-AO SNE support", where it gets used (Simon)
- Fix rebase artifact in tcp_v6_reqsk_send_ack(), which adds
  compile-error on a patch in the middle of series (Simon)
- Another rebase artifact in tcp_v6_reqsk_send_ack() that makes
  keyid, requested by peer on ipv6 reqsk ACKs not respected (Simon)

Version 10: https://lore.kernel.org/all/20230815191455.1872316-1-dima@arista.com/T/#u

The pre-v10 changelog is on version 10 cover-letter.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>
Cc: Dan Carpenter <error27@gmail.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: David Laight <David.Laight@aculab.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Donald Cassidy <dcassidy@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Francesco Ruggeri <fruggeri05@gmail.com>
Cc: Gaillardetz, Dominik <dgaillar@ciena.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Ivan Delalande <colona@arista.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Leonard Crestez <cdleonard@gmail.com>
Cc: Nassiri, Mohammad <mnassiri@ciena.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Tetreault, Francois <ftetreau@ciena.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Dmitry Safonov (23):
  net/tcp: Prepare tcp_md5sig_pool for TCP-AO
  net/tcp: Add TCP-AO config and structures
  net/tcp: Introduce TCP_AO setsockopt()s
  net/tcp: Prevent TCP-MD5 with TCP-AO being set
  net/tcp: Calculate TCP-AO traffic keys
  net/tcp: Add TCP-AO sign to outgoing packets
  net/tcp: Add tcp_parse_auth_options()
  net/tcp: Add AO sign to RST packets
  net/tcp: Add TCP-AO sign to twsk
  net/tcp: Wire TCP-AO to request sockets
  net/tcp: Sign SYN-ACK segments with TCP-AO
  net/tcp: Verify inbound TCP-AO signed segments
  net/tcp: Add TCP-AO segments counters
  net/tcp: Add TCP-AO SNE support
  net/tcp: Add tcp_hash_fail() ratelimited logs
  net/tcp: Ignore specific ICMPs for TCP-AO connections
  net/tcp: Add option for TCP-AO to (not) hash header
  net/tcp: Add TCP-AO getsockopt()s
  net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)
  net/tcp: Add static_key for TCP-AO
  net/tcp: Wire up l3index to TCP-AO
  net/tcp: Add TCP_AO_REPAIR
  Documentation/tcp: Add TCP-AO documentation

 Documentation/networking/index.rst  |    1 +
 Documentation/networking/tcp_ao.rst |  444 +++++
 include/linux/sockptr.h             |   23 +
 include/linux/tcp.h                 |   30 +-
 include/net/dropreason-core.h       |   30 +
 include/net/tcp.h                   |  288 +++-
 include/net/tcp_ao.h                |  362 ++++
 include/uapi/linux/snmp.h           |    5 +
 include/uapi/linux/tcp.h            |  105 ++
 net/ipv4/Kconfig                    |   17 +
 net/ipv4/Makefile                   |    2 +
 net/ipv4/proc.c                     |    5 +
 net/ipv4/syncookies.c               |    4 +
 net/ipv4/tcp.c                      |  246 +--
 net/ipv4/tcp_ao.c                   | 2392 +++++++++++++++++++++++++++
 net/ipv4/tcp_input.c                |   98 +-
 net/ipv4/tcp_ipv4.c                 |  363 +++-
 net/ipv4/tcp_minisocks.c            |   50 +-
 net/ipv4/tcp_output.c               |  236 ++-
 net/ipv4/tcp_sigpool.c              |  358 ++++
 net/ipv6/Makefile                   |    1 +
 net/ipv6/syncookies.c               |    5 +
 net/ipv6/tcp_ao.c                   |  168 ++
 net/ipv6/tcp_ipv6.c                 |  376 +++--
 24 files changed, 5174 insertions(+), 435 deletions(-)
 create mode 100644 Documentation/networking/tcp_ao.rst
 create mode 100644 include/net/tcp_ao.h
 create mode 100644 net/ipv4/tcp_ao.c
 create mode 100644 net/ipv4/tcp_sigpool.c
 create mode 100644 net/ipv6/tcp_ao.c


base-commit: c4eee56e14fe001e1cff54f0b438a5e2d0dd7454
-- 
2.42.0


