Return-Path: <netdev+bounces-38100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0119C7B9805
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 356C4281862
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9B101D4;
	Wed,  4 Oct 2023 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Vz/Hwh4D"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F28110F
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 22:36:41 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB3D7
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 15:36:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-327be5fe4beso340751f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 15:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696458997; x=1697063797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MoFsOouNLsiRSc0IkOSoU7t8c12ZxAQ0uDmkn8wVHwA=;
        b=Vz/Hwh4DDw+n+mCcBSIIWR6ZKjPTN1fvrLUAiH4cUudr4XlhQugAj9v+GwmYvBP6xJ
         /AGGRCYiCK81b9pXCHuMDNp/+PlT88xH+nbxOwsQwesmgnyF2ON4SaxAG6S5bJc8BO4C
         +RA7vaA/TlQGi4KZnbw3ESJLA24RoiYZJm6Pj8aTRL22SJPqom/dsuVLRJuQMZy/J/3y
         +nFNeLihRoiQiDQL1LCK2sPUydPn0hFXfXqpCTr19ZA5Tj5nDQPvqqe1NSzzK+5eq1CH
         Ppc4YaXJFO6BEiq/oRRLvu+8SdIZ39bWU/Uir/RYD8/H81Br3MPjTNEsMnpjYWRptBfl
         8igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458997; x=1697063797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoFsOouNLsiRSc0IkOSoU7t8c12ZxAQ0uDmkn8wVHwA=;
        b=giFJN/RUDsrKuELTkk33kOX6b4X3fUb9uEyP1RKik5hPD4ju480CUvmkEG3PlDB782
         TBbn+F4q/vx4fqyuIA9s6iEzWAKnyIgPoB/m//cov2eoR9+DUyzQYjiLWqE64BBQmD1l
         8rUpJTxLGnMi0LZl7Nhzota7evKjnJvwGZC5NIyFG0ws4i7hS3s5maoHPnzaWOCqXopz
         PZ/ziVeu9cvT/4gqnnMsEjaRAYESWdKdvjOnKQtksCADAvH/+Ay9QinHL1bXBIsqFXDx
         IN8UFHUYoHF3GZ7EeFOlvQ0jiS9hBomVaFIsg78m/H5oeVm3rQeaL33+2nIE5pW3yv+n
         iF9Q==
X-Gm-Message-State: AOJu0YzRyuz6vjsvTUIzOxZ5tuJkFo8J2wlgPDDKE+DjMZ2TAcDyhyqP
	AUE8qciOjmnfpIo292mH9YTlzw==
X-Google-Smtp-Source: AGHT+IEF6vYXonOYIuVynNUE1iYf9OWkMIoM7prxPuwO6ilRIbVTyM0Wz8iWLnlBo/CG8BvCTx+M9A==
X-Received: by 2002:adf:fac8:0:b0:320:9c8:40af with SMTP id a8-20020adffac8000000b0032009c840afmr2952477wrs.11.1696458997094;
        Wed, 04 Oct 2023 15:36:37 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4d0b000000b0031ff89af0e4sm181412wrt.99.2023.10.04.15.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 15:36:36 -0700 (PDT)
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
	Simon Horman <simon.horman@corigine.com>,
	"Tetreault, Francois" <ftetreau@ciena.com>,
	netdev@vger.kernel.org,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v13 net-next 00/23] net/tcp: Add TCP-AO support
Date: Wed,  4 Oct 2023 23:36:04 +0100
Message-ID: <20231004223629.166300-1-dima@arista.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

This is version 13 of TCP-AO support. It addresses Paolo's review
comments and makes TCP simultaneous open work with AO. In order
to check TCP-AO + simultaneous open, a new TCP self-connect
selftest was written (to be sent later with tcp-ao-selftests
separately).

There's one Sparse warning introduced by tcp_sigpool_start():
__cond_acquires() seems to currently being broken. I've described
the reasoning for it on v9 cover letter. Also, checkpatch.pl warnings
were addressed, but yet I've left the ones that are more personal
preferences (i.e. 80 columns limit). Please, ping me if you have
a strong feeling about one of them.

The following changes since commit 07cf7974a2236a66f989869c301aa0220f33905c:

  Merge tag 'nf-next-23-09-28' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next (2023-10-04 14:25:37 -0700)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-v13

for you to fetch changes up to dfd8d1df4562cd7a3a94a5e813a902f66a312672:

  Documentation/tcp: Add TCP-AO documentation (2023-10-04 23:00:34 +0100)

----------------------------------------------------------------

And another branch with selftests, that will be sent later separately:
  git@github.com:0x7f454c46/linux.git tcp-ao-v13-with-selftests

Thanks for your time and reviews,
         Dmitry

--- Changelog ---

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
Cc: Simon Horman <simon.horman@corigine.com>
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
 Documentation/networking/tcp_ao.rst |  434 +++++
 include/linux/sockptr.h             |   23 +
 include/linux/tcp.h                 |   30 +-
 include/net/dropreason-core.h       |   30 +
 include/net/tcp.h                   |  288 +++-
 include/net/tcp_ao.h                |  361 ++++
 include/uapi/linux/snmp.h           |    5 +
 include/uapi/linux/tcp.h            |  105 ++
 net/ipv4/Kconfig                    |   17 +
 net/ipv4/Makefile                   |    2 +
 net/ipv4/proc.c                     |    5 +
 net/ipv4/syncookies.c               |    4 +
 net/ipv4/tcp.c                      |  246 +--
 net/ipv4/tcp_ao.c                   | 2389 +++++++++++++++++++++++++++
 net/ipv4/tcp_input.c                |   98 +-
 net/ipv4/tcp_ipv4.c                 |  363 +++-
 net/ipv4/tcp_minisocks.c            |   50 +-
 net/ipv4/tcp_output.c               |  236 ++-
 net/ipv4/tcp_sigpool.c              |  358 ++++
 net/ipv6/Makefile                   |    1 +
 net/ipv6/syncookies.c               |    5 +
 net/ipv6/tcp_ao.c                   |  168 ++
 net/ipv6/tcp_ipv6.c                 |  374 +++--
 24 files changed, 5158 insertions(+), 435 deletions(-)
 create mode 100644 Documentation/networking/tcp_ao.rst
 create mode 100644 include/net/tcp_ao.h
 create mode 100644 net/ipv4/tcp_ao.c
 create mode 100644 net/ipv4/tcp_sigpool.c
 create mode 100644 net/ipv6/tcp_ao.c


base-commit: 07cf7974a2236a66f989869c301aa0220f33905c
-- 
2.42.0


