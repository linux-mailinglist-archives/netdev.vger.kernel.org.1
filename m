Return-Path: <netdev+bounces-291475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AfWHVO8FGpUPwcAu9opvQ
	(envelope-from <netdev+bounces-291475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:17:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9565CED77
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D5430247E0
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F8184;
	Mon, 25 May 2026 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+YQifOf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29914391507
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743775; cv=none; b=L14C/ZeWZa8xMIuHT8laXv4eTLNRv+mOw6FJiXFokM1OZqtWUaPCfHR+Jo9w5aq1vCr/LTrmQJRdZYe5PIOLGTu7Gql+ivJADjQEvPB7SqWplyNoxSemauXQNRfd3oDIGqVW0LfAFdz1eaZChu5vzbriTKrxC3ocnfZz1qcbozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743775; c=relaxed/simple;
	bh=AfOXVKrCgINv1SXgYMt6reFbqZ4LZghe1O5kZWevjw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J82N6RLTQHqjTWtPG0TA4D33V3+FUiZPWmnQKKIYxn14gSTRDhHh0avzwo5ylmHquvz3mQ+n9wwSzeVbrKC5uMnEq529jtVKdsiCwLvRwYripTlvUF580RQ/ElXakPEAwLZ6PBkjGSV0iALNeUWnnwP+ENEyAWxO2JfvSVB7eJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+YQifOf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878111F000E9;
	Mon, 25 May 2026 21:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779743774;
	bh=YK/ZBgPpjXL2rcMJZCFT4AiPOKk03YYUIQBET2s3BoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q+YQifOftCKQen72GPVdg/W3BlyapQd9dUThFiJR3zNbcZQMijkvKmNvNgYQQWF+o
	 a9I9CzvxQ8SCV07HmZFQTWO8W9Xqc46+uwrt9rwTTNURRpmHd9u2pbW0aFB3RpGqqQ
	 RxqgIqsNo6SuXKz2LQJk5EXGYIcMr0o2Yn75hkxk6+DjH0Q8KhGIRG8OJob+JpITnG
	 +6cPXWcIdLNQye5vBKuhtKJdX5J76TJy4eUTyTmdsnatARk7jh8dYFxobLUv9Aozwh
	 X2wTcuNshAvfAoCu4/keXf90XgqJkWmP7spA+WB4E30hMlzpWucMNdyrt1qlezZjSD
	 zwb3zWgP2qQhg==
From: Jakub Kicinski <kuba@kernel.org>
To: rjethwani@purestorage.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org
Subject: Re: [PATCH v14 9/9] selftests: net: add TLS hardware offload test
Date: Mon, 25 May 2026 14:16:12 -0700
Message-ID: <20260525211612.2508513-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515212715.3151307-10-rjethwani@purestorage.com>
References: <20260515212715.3151307-10-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com,queasysnail.net,davemloft.net,redhat.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291475-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CB9565CED77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
selftests: net: add TLS hardware offload test

This commit adds a two-node kTLS HW offload selftest under
tools/testing/selftests/drivers/net/hw/. A C helper binary acts as TLS
client or server, and a Python harness drives it and verifies TLS stat
counters across TLS 1.2/1.3 and AES-GCM-128/256 with rekey variants.

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> new file mode 100644
> index 000000000000..2b82e6af55ef
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c

[ ... ]

> +static void derive_key_fields(unsigned char *key, int key_size,
> +			      unsigned char *iv, int iv_size,
> +			      unsigned char *salt, int salt_size,
> +			      unsigned char *rec_seq, int rec_seq_size,
> +			      int generation)
> +{
> +	int i;
> +
> +	for (i = 0; i < key_size; i++)
> +		key[i] ^= generation;
> +	for (i = 0; i < iv_size; i++)
> +		iv[i] ^= generation;
> +	for (i = 0; i < salt_size; i++)
> +		salt[i] ^= generation;
> +	memset(rec_seq, 0, rec_seq_size);
> +}

[Low]
Does this XOR truncate the generation to 8 bits? key[] is unsigned char,
so key[i] ^= generation only mixes in the low byte of the int. Generations
that differ only in their high bytes (0 vs 256, 1 vs 257, ...) end up
producing the same key, iv, and salt:

	for (i = 0; i < key_size; i++)
		key[i] ^= generation;

Currently the Python harness caps rekeys at 50, so this is not exercised,
but parse_int_arg accepts -k up to INT_MAX. A manual run with -k 256 or
beyond would silently install duplicate keys across generations. Should
the per-byte mix incorporate more of the generation value, or should the
accepted range be bounded to keep generations distinct?

[ ... ]

> +static int recv_tls_message(int fd, char *buf, size_t buflen, int *record_type,
> +			    int flags)
> +{
> +	char cmsg_buf[CMSG_SPACE(sizeof(unsigned char))];
> +	struct msghdr msg = {0};
> +	struct cmsghdr *cmsg;
> +	struct iovec iov;
> +	int ret;
> +
> +	iov.iov_base = buf;
> +	iov.iov_len = buflen;
> +
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +	msg.msg_control = cmsg_buf;
> +	msg.msg_controllen = sizeof(cmsg_buf);
> +
> +	ret = recvmsg(fd, &msg, flags);
> +	if (ret <= 0)
> +		return ret;
> +
> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	if (cmsg && cmsg->cmsg_level == SOL_TLS &&
> +	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE)
> +		*record_type = *((unsigned char *)CMSG_DATA(cmsg));
> +
> +	return ret;
> +}

[ ... ]

> +static int check_ekeyexpired(int fd)
> +{
> +	char buf[MIN_BUF_SIZE];
> +	int ret;
> +
> +	ret = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
> +	if (ret == -1 && errno == EKEYEXPIRED) {
> +		printf("recv() returned EKEYEXPIRED as expected\n");
> +		return 0;
> +	} else if (ret == -1 && errno == EAGAIN) {
> +		printf("recv() returned EAGAIN (no pending data)\n");
> +		return 0;
> +	} else if (ret > 0) {
> +		printf("FAIL: recv() returned %d bytes, expected EKEYEXPIRED\n",
> +		       ret);
> +		return -1;
> +	} else {
> +		printf("FAIL: recv() returned unexpected error: %s\n",
> +		       strerror(errno));
> +		return -1;
> +	}
> +}

[Low]
Is this errno set complete for burst mode? check_ekeyexpired() is called
from server_rekey() (burst mode included) and only accepts EKEYEXPIRED and
EAGAIN. The comment in server_verify_burst() and the comment in
verify_tls_counters() in tls_hw_offload.py both describe records straddling
the rekey boundary as causing a transient EBADMSG stashed on sk_err:

	/* A short data return under MSG_WAITALL means a follow-on
	 * record failed to decrypt mid-recv (kTLS returns the prior
	 * decrypted bytes and stashes -EBADMSG on sk_err). Probe
	 * with one more recv to surface the underlying error.
	 */

If kTLS surfaces EBADMSG (or another errno) on the boundary recv() in
check_ekeyexpired(), wouldn't the burst rekey path FAIL spuriously even
though the harness elsewhere acknowledges this is expected?

[ ... ]

> +static int do_server(void)
> +{
> +	int lsk = -1, csk = -1;
> +	ssize_t n, total = 0;
> +	int test_result = -1;
> +	int current_gen = 0;
> +	int recv_count = 0;
> +	int send_iter = 1;
> +	char *buf = NULL;
> +	int record_type;
> +	int recv_flags;
> +	int buf_size;

[Low]
Should record_type be initialized here? recv_tls_message() only writes
*record_type when CMSG_FIRSTHDR is non-NULL and matches SOL_TLS /
TLS_GET_RECORD_TYPE; the sibling recv_tls_keyupdate() declares it as
int record_type = 0. In do_server(), record_type is left uninitialized
and the main loop branches on:

	if (record_type == TLS_RECORD_TYPE_HANDSHAKE) {

If the cmsg ever arrives truncated or absent, would the read of
record_type be undefined and potentially misclassify a data record as a
KeyUpdate (or vice versa)?

[ ... ]

> +	buf_size = send_size;
> +	if (buf_size < MIN_BUF_SIZE)
> +		buf_size = MIN_BUF_SIZE;
> +	buf = malloc(buf_size);

[ ... ]

> +static int server_verify_burst(int fd, char *buf, int buf_size,
> +			       ssize_t n, int send_iter)
> +{
> +	unsigned char expect = send_iter & 0xFF;
> +	int j;
> +
> +	if (n != send_size) {
> +		int record_type = 0;
> +		ssize_t n2;
> +
> +		/* A short data return under MSG_WAITALL means a follow-on
> +		 * record failed to decrypt mid-recv (kTLS returns the prior
> +		 * decrypted bytes and stashes -EBADMSG on sk_err). Probe
> +		 * with one more recv to surface the underlying error.
> +		 */
> +		n2 = recv_tls_message(fd, buf, buf_size, &record_type, 0);
> +		printf("FAIL: short recv in burst mode: got %zd, expected %d (iter %d)\n",
> +		       n, send_size, send_iter);
> +		printf("      follow-up recv: %zd errno=%s\n",
> +		       n2, n2 < 0 ? strerror(errno) : "ok");
> +		return -1;
> +	}

[Low]
Can this cause a spurious failure when -b is small and -B is set? The
recv() target under MSG_WAITALL is buf_size, and do_server() raises
buf_size to MIN_BUF_SIZE (16) when send_size is smaller:

	buf_size = send_size;
	if (buf_size < MIN_BUF_SIZE)
		buf_size = MIN_BUF_SIZE;

With for example -b 1 -B, the kernel waits for 16 bytes (aggregating
multiple 1-byte data records) and recv returns n=16, but
server_verify_burst() compares against send_size (1):

	if (n != send_size) { ... return -1; }

Should the recv length be capped at send_size in burst mode, or should
send_size < MIN_BUF_SIZE be rejected at parse time so the two cannot
diverge?

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> new file mode 100755
> index 000000000000..94dd9d692bb1
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

[ ... ]

> +def check_tls_support(cfg):
> +    try:
> +        cmd("test -f /proc/net/tls_stat")
> +        cmd("test -f /proc/net/tls_stat", host=cfg.remote)
> +    except CmdExitFailure as e:
> +        raise KsftSkipEx(f"kTLS not supported: {e}")

[Medium]
Should this also gate on the device's TLS HW offload features? The test
lives under drivers/net/hw/, which is a generic NIC test directory used
in CI across many vendors. check_tls_support() only checks for
/proc/net/tls_stat (a kernel-config gate for kTLS itself). It does not
look at NETIF_F_HW_TLS_TX/NETIF_F_HW_TLS_RX or the ethtool features
tls-hw-tx-offload/tls-hw-rx-offload.

verify_tls_counters() then unconditionally requires HW offload on the
DUT:

	dev = stat_diff(before, after, f'Tls{direction}Device')
	sw = stat_diff(before, after, f'Tls{direction}Sw')
	if require_hw:
		if dev < 1:
			ksft_pr(f"FAIL: ...")
			return 1

On any DUT where kTLS runs in software, would this test FAIL rather than
SKIP? Sibling tests (e.g. tso.py) raise KsftSkipEx based on
cfg.hw_features; could the same pattern be used here?

[ ... ]

> +def verify_tls_counters(stats_before, stats_after, expected_rekeys,
> +                        tls_role, is_dut, burst=False):

[ ... ]

> +    # In burst mode, records straddling the rekey boundary cause a transient
> +    # EBADMSG in tls_decrypt_sw() before tls_rx_rekey_retry() succeeds,
> +    # so TlsDecryptError increments are expected.
> +    if not burst:
> +        errors += check_zero(stats_before, stats_after, 'TlsDecryptError', role)
> +
> +    return errors

[Low]
The commit message says the harness verifies "TLS stat counters (RekeyOk,
RekeyReceived, RekeyFallback, RekeyInProgress, DecryptError)". Is
DecryptError still verified in burst mode? The check is skipped entirely
under burst rather than bounded (e.g. by expected_rekeys * N).

Would a regression that produces hundreds of decrypt errors in a burst
run go undetected, given the listed counter set in the commit message?

