Return-Path: <netdev+bounces-263523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBBoIYKMp2nliAAAu9opvQ
	(envelope-from <netdev+bounces-263523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:36:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D741F9835
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F8C731F297D
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC2030EF91;
	Wed,  4 Mar 2026 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6HKV1+y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA2630EF86;
	Wed,  4 Mar 2026 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587688; cv=none; b=gqj44YAbQ47nsqm04iKmVUArg5IkDy+D7MknvUk7mx7QUEuWy27FOXVkDxFHtX0C1EYHhNIz+Hbb0I0t92MurvwE0qxE18MxiftXbNOs4FkHoyYKKeGQJ+Og1egdECqd9g10OD7Q5mRFORgnDp5tk33b9FSag5m75+D0XVBkpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587688; c=relaxed/simple;
	bh=HqAFB1lHQ8NQavXeRY3xmFzoTmksaDqu9VBPXstizDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drURo7n01oV4zi0r1J7Sp9uX1XWTJJ5q/y0XxtJWth3rnDVwgtQjgZzHojI+7GkUGkwMExH8NCkJ4DhY3ojj9thtU400Xe0oBGLFpOS0UC9XCwY0lMAYxn7nDwYbbEOSkSv44qlXl1AAnUMBA7JA5UjmLdbSR8GtXi5R/RaIAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6HKV1+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6F3C116C6;
	Wed,  4 Mar 2026 01:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587687;
	bh=HqAFB1lHQ8NQavXeRY3xmFzoTmksaDqu9VBPXstizDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6HKV1+y9u905MRuDoXo8chCSxORg0FcbC/QcGk6dQolkbCT2r/ykuCABA1NE3mNP
	 GYsIo6jrWrIRz7F/f5T1c2slOmEblfCLexFWr5UOfUqH0zfHCY6Kr6WMtvXjRO9oTq
	 xJ2yvO+ddD5HfIVaEHV4P5tDnshaXD/70w59dqC0OIBKwVNH0E1LPuHU+hXIi3bp/g
	 9Way/mTvohwiX2ohKjaVP4H+ILFzBQeEDp3EtpIdwWui/DOpKBeTfriob/y5BV3dpI
	 VN0V/JDF/C4u3Z0rDHjupf8fvoLv6k6Rh4XFR2pK9HTvxK4yf56o+iQXXQw8UGTxIf
	 rfr1mA3x99bwA==
From: Jakub Kicinski <kuba@kernel.org>
To: mike.marciniszyn@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	xiaopei01@kylinos.cn,
	mohsin.bashr@gmail.com,
	linux@armlinux.org.uk,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	skhawaja@google.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	andrew+netdev@lunn.ch,
	kernel-team@meta.com,
	sdf@fomichev.me,
	horms@kernel.org,
	kuniyu@google.com,
	jacob.e.keller@intel.com,
	liuhangbin@gmail.com,
	alexanderduyck@fb.com,
	pabeni@redhat.com,
	lee@trager.us
Subject: Re: [net-next,v2.2,3/5] eth fbnic: Add msix self test
Date: Tue,  3 Mar 2026 17:27:55 -0800
Message-ID: <20260304012755.2594853-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301110606.3739-4-mike.marciniszyn@gmail.com>
References: <20260301110606.3739-4-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1D741F9835
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263523-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,kylinos.cn,gmail.com,armlinux.org.uk,google.com,vger.kernel.org,davemloft.net,linaro.org,lunn.ch,meta.com,fomichev.me,intel.com,fb.com,redhat.com,trager.us];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eth fbnic: Add msix self test

This function is meant to test the global interrupt registers and the
PCIe IP MSI-X functionality. It essentially goes through and tests
various combinations of the set, clear, and mask bits in order to
verify the behavior is as we expect it to be from the driver.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index 779a083b9215..092fa9ad93d0 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -194,6 +194,36 @@ void fbnic_synchronize_irq(struct fbnic_dev *fbd, int nr);
>  int fbnic_request_irq(struct fbnic_dev *dev, int nr, irq_handler_t handler,
>  		      unsigned long flags, const char *name, void *data);
>  void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
> +
> +/**
> + * enum fbnic_msix_self_test_codes - return codes from self test routines
> + *
> + * These are the codes returned from the self test routines and
> + * stored in the test result array indexed by the specific
> + * test name.
> + *
> + * @FBNIC_TEST_MSIX_SUCCESS: no errors
> + * @FBNIC_TEST_MSIX_NOMEM: allocation failure
> + * @FBNIC_TEST_MSIX_IRQ_REQ_FAIL: IRQ request failure
> + * @FBNIC_TEST_MSIX_MASK: masking failed to prevent IRQ
> + * @FBNIC_TEST_MSIX_UNMASK: unmasking failure w/ sw status set
> + * @FBNIC_TEST_MSIX_IRQ_CLEAR: interrupt when clearing mask
> + * @FBNIC_TEST_MSIX_NO_INTERRUPT: no interrupt when not masked
> + * @FBNIC_TEST_MSIX_NO_CLEAR_OR_MASK: status not cleared, or mask not set
> + */
> +enum fbnic_msix_self_test_codes {
> +	FBNIC_TEST_MSIX_SUCCESS = 0,
> +	FBNIC_TEST_MSIX_NOMEM = 5,
> +	FBNIC_TEST_MSIX_IRQ_REQ_FAIL = 10,
> +	FBNIC_TEST_MSIX_MASK = 20,
> +	FBNIC_TEST_MSIX_UNMASK = 30,
> +	FBNIC_TEST_MSIX_IRQ_CLEAR = 40,
> +	FBNIC_TEST_MSIX_NO_INTERRUPT = 50,
> +	FBNIC_TEST_MSIX_NO_CLEAR_OR_MASK = 60,
> +};

[ ... ]

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
> index 02e8b0b257fe..2099ee89fb51 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c

[ ... ]

> @@ -238,6 +238,160 @@ void fbnic_free_irq(struct fbnic_dev *fbd, int nr, void *data)
>  	free_irq(irq, data);
>  }
>
> +struct fbnic_msix_test_data {
> +	struct fbnic_dev *fbd;
> +	unsigned long test_msix_status[BITS_TO_LONGS(FBNIC_MAX_MSIX_VECS)];
> +	int irq_vector[FBNIC_MAX_MSIX_VECS];
> +};
> +
> +static irqreturn_t fbnic_irq_test(int irq, void *data)
> +{
> +	struct fbnic_msix_test_data *test_data = data;
> +	struct fbnic_dev *fbd = test_data->fbd;
> +	int i;
> +
> +	for (i = fbd->num_irqs; i--;) {
> +		if (test_data->irq_vector[i] == irq) {
> +			set_bit(i, test_data->test_msix_status);
> +			break;
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * fbnic_msix_test - Verify behavior of NIC interrupts
> + * @fbd: device to test
> + *
> + * This function is meant to test the global interrupt registers and the
> + * PCIe IP MSI-X functionality. It essentially goes through and tests
> + * various combinations of the set, clear, and mask bits in order to
> + * verify the behavior is as we expect it to be from the driver.
> + *
> + * Return: See enum fbnic_msix_self_test_codes
> + **/
> +enum fbnic_msix_self_test_codes fbnic_msix_test(struct fbnic_dev *fbd)
> +{
> +	enum fbnic_msix_self_test_codes result = FBNIC_TEST_MSIX_SUCCESS;
> +	struct pci_dev *pdev = to_pci_dev(fbd->dev);
> +	struct fbnic_msix_test_data *test_data;
> +	u32 mask = 0;
> +	int i;
> +
> +	/* Allocate bitmap and IRQ vector table */
> +	test_data = kzalloc(sizeof(*test_data), GFP_KERNEL);
> +
> +	/* memory allocation failure */
> +	if (!test_data)
> +		return FBNIC_TEST_MSIX_NOMEM;
> +
> +	/* Initialize test data */
> +	test_data->fbd = fbd;
> +
> +	for (i = FBNIC_NON_NAPI_VECTORS; i < fbd->num_irqs; i++) {
> +		/* Add IRQ to vector table so it can be found */
> +		test_data->irq_vector[i] = pci_irq_vector(pdev, i);
> +
> +		/* Enable the interrupt */
> +		if (!fbnic_request_irq(fbd, i, fbnic_irq_test, 0,
> +				       fbd->netdev->name, test_data))
> +			continue;
> +
> +		while (i-- > FBNIC_NON_NAPI_VECTORS)
> +			fbnic_free_irq(fbd, i, test_data);
> +		kfree(test_data);
> +
> +		/* IRQ request failure */
> +		return FBNIC_TEST_MSIX_IRQ_REQ_FAIL;
> +	}
> +
> +	/* Test each bit individually */
> +	for (i = FBNIC_NON_NAPI_VECTORS; i < fbd->num_irqs; i++) {
> +		mask = 1U << (i % 32);
> +
> +		/* Start with mask set and interrupt cleared */
> +		fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(i / 32), mask);
> +		fbnic_wrfl(fbd);
> +		fbnic_wr32(fbd, FBNIC_INTR_CLEAR(i / 32), mask);
> +		fbnic_wrfl(fbd);
> +
> +		/* masking failure to prevent interrupt */
> +		result = FBNIC_TEST_MSIX_MASK;
> +
> +		fbnic_wr32(fbd, FBNIC_INTR_SET(i / 32), mask);
> +		fbnic_wrfl(fbd);
> +		usleep_range(10000, 11000);
> +
> +		if (test_bit(i, test_data->test_msix_status))
> +			break;
> +
> +		/* unmasking failure w/ sw status set */
> +		result = FBNIC_TEST_MSIX_UNMASK;
> +
> +		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(i / 32), mask);
> +		fbnic_wrfl(fbd);
> +		usleep_range(10000, 11000);
> +
> +		if (!test_bit(i, test_data->test_msix_status))
> +			break;
> +
> +		/* interrupt when clearing mask */
> +		result = FBNIC_TEST_MSIX_IRQ_CLEAR;
> +
> +		clear_bit(i, test_data->test_msix_status);
> +		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(i / 32), mask);
> +		fbnic_wrfl(fbd);
> +		usleep_range(10000, 11000);
> +
> +		if (test_bit(i, test_data->test_msix_status))
> +			break;
> +
> +		/* interrupt not triggering when not masked */
> +		result = FBNIC_TEST_MSIX_NO_INTERRUPT;
> +
> +		fbnic_wr32(fbd, FBNIC_INTR_SET(i / 32), mask);
> +		fbnic_wrfl(fbd);
> +		usleep_range(10000, 11000);
> +
> +		if (!test_bit(i, test_data->test_msix_status))
> +			break;
> +
> +		/* status not cleared, or mask not set */
> +		result = FBNIC_TEST_MSIX_NO_CLEAR_OR_MASK;
> +		if (mask & fbnic_rd32(fbd, FBNIC_INTR_STATUS(i / 32)))
> +			break;
> +		if (!(mask & fbnic_rd32(fbd, FBNIC_INTR_MASK(i / 32))))
> +			break;
> +
> +		/* Result = 0 - Success */
> +		result = FBNIC_TEST_MSIX_SUCCESS;
> +
> +		clear_bit(i, test_data->test_msix_status);
> +	}
> +
> +	if (i < fbd->num_irqs) {
> +		fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(i / 32), mask);
> +		fbnic_wrfl(fbd);
> +		fbnic_wr32(fbd, FBNIC_INTR_CLEAR(i / 32), mask);
> +		fbnic_wrfl(fbd);
> +		clear_bit(i, test_data->test_msix_status);
> +	}
> +
> +	for (i = FBNIC_NON_NAPI_VECTORS; i < fbd->num_irqs; i++) {
> +		/* Test for bits set after testing */
> +		if (test_bit(i, test_data->test_msix_status))
> +			result = 70;
                    ^^

Should the value 70 have a named constant in enum fbnic_msix_self_test_codes?

The function returns enum fbnic_msix_self_test_codes, which defines values
SUCCESS (0), NOMEM (5), IRQ_REQ_FAIL (10), MASK (20), UNMASK (30),
IRQ_CLEAR (40), NO_INTERRUPT (50), and NO_CLEAR_OR_MASK (60).

The value 70 appears to indicate a stray interrupt was detected after
testing completed, but this error condition has no corresponding named enum
constant. This makes the error code returned to userspace via ethtool
undocumented and prevents matching it to a failure description.

Should a constant such as FBNIC_TEST_MSIX_STRAY_INTERRUPT be added to the
enum to maintain consistency with all other error codes in this function?

> +
> +		/* Free IRQ */
> +		fbnic_free_irq(fbd, i, test_data);
> +	}
> +
> +	kfree(test_data);
> +
> +	return result;
> +}
-- 
pw-bot: cr

