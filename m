Return-Path: <netdev+bounces-264898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CQqDq0qq2luaQEAu9opvQ
	(envelope-from <netdev+bounces-264898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:27:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F32270C8
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3806301DE3F
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389DA371043;
	Fri,  6 Mar 2026 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVxN2mtt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3595C41C0C2
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825258; cv=none; b=S37J5ZSSR2cqPRDEC9CwAIsvNBkT2h06T77kkbyh8BG0g8uIWXc+gXH2wfAODPsqtUASjgDXkOvAQMqAer1cA6yqmw76YgELRdyNl/r7pIhm9oDEyn7ZVXcuzcZRtmaSr+KyYFgf4/bpNWRlLXm75AWGh89rMKyDGIv49BR8m4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825258; c=relaxed/simple;
	bh=cLFs9JgG7yyixFSFy76PtbHPsPDAs3NUs5UCENCb7BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqjXlFe0u9hQn3O2tQjNBPG5lJUtyq9YqITa6FTeJT9X9cXlAiXoeeqPAYocQ/oPjtwH3jyCarHWh0ffB+UT6erBPzKI3DoRnsTA+v5ntc0sM9gGlDSdUtw4oCdrQ60v+Eir4ZDzuMSzsiEA8eqXfx6RKVmJodOmxgBmfiA2ytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVxN2mtt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd759f502dso24934285a.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 11:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772825255; x=1773430055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqyOgvXgFpMsGQ9v5p9MGDV05Gt6MHckNyxxkD1OwVM=;
        b=AVxN2mttLPRvLBPPQH7ERtLrwDORgczsZZCtlcAibbggyKOW1rRQ95nfNaq0fw1tl3
         PQnpEaL6iWKQ9VyYTNOAU7TwGPc2sEmwRSGgktpXqNpPUXUZkAzLhjLYDmZPGTdCoNoA
         wrirnsjwmCofi5DzEi6ptdzHYY+PIJUgnMSD4g0IxHOK715aWvTsg/RrNvukU+EKikH5
         5++TpNP2LhAwUkhRHjCC/kVpCXyXkDkjD+jD3lt3mD5AQcCBVmFMXPHDmhJ2sPDWtJoJ
         Pc7RKv1shesWkAhIsbmr/oWTYdjKeDQh62yNhBOpdvaFaNzkjq9hXZEAL2dKpRFWyMnN
         lXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825255; x=1773430055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqyOgvXgFpMsGQ9v5p9MGDV05Gt6MHckNyxxkD1OwVM=;
        b=MbPW47R6NArAn2uJawfLO02xu1fh05KxaNeYKOeHqyHl2ojhcZZ/06wyJ8lMMGB5x6
         Lr6/njiC3lJFxpTZqzgV3qDRpGlc7kvHGBJB7kWqCGoV7cND0/Rv9VHnJnjQBV0fIM9R
         /n33NkokXM85H62VKYuEXnIAyPdoo/weIiTUtOW9XUK8TPoYGeSnPLTzJsvqjpYAVXM1
         h/Wd0FgNXRF1uwACN8epJYx9XjvnPyeBwSVNdeII24jlhyrDU1SGWJmkGUoh7KvwdVFU
         jRT5oB8ggi7FBojM1sv378YcI1hP+mhVsdZWIckyR9OxA9P0ZqecYkU1qDBv3/U4qw1F
         X3IA==
X-Gm-Message-State: AOJu0YyndJ6W+RdGuuT2/7QPdMGByMUQ5cFjWAAFo6gd1XEsA7y7v31z
	bxJ7r3wH4rsRARjdjYbjkVJc06APmL+by/kJel8Fp6+Vi6NSjFWr8olK
X-Gm-Gg: ATEYQzxuetxIzQ5xmLVgRFITcKfMTbK8Ahkd5W6VLsU+Se3xjtrPWW7a/co8swq2Afp
	2mh+leI0HqF0EmRj+6aXEJzpcuAWTLyYBY6CPmw4vt8LvVO0Ct3Ei7tNnj441lpnmv96rB4tyCH
	L8A9fOQupZZU/MWSXc8OEHR/Th/LW1ack7mtWl2v5xoBh164yd3uW5gosi66GB4zHscf2IGs4Ge
	Nq4H9PoHCf5BW43eSl3ZBobXrqpbZsJNZXucjc9trLwRJ8W0ssBX1+ZcEZ2bHQg/2ldaGsocmSp
	CNUkk5psFhcdspcAxZ9Oi5SlWZWI1FsDlxpObAYXwbrlEFAsZAMOZ6bwi8jIvQ6Y3EQraQDjUeB
	rP3TcYS296aUiIZv/3gGkdDVODCgH+E4n31Jx3PAlfnWyAfu1mkICl/iaFMxBlcZGBlCYIhU8T6
	hebT1l6eTiPagZaCUMQXIQfQwYqHQrbaVz2r3AQ4w4ZLjO57HHam7SXlzm
X-Received: by 2002:a05:620a:bc1:b0:8c7:1119:2994 with SMTP id af79cd13be357-8cd6d4d51f6mr409609485a.64.1772825255120;
        Fri, 06 Mar 2026 11:27:35 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3144e0d5sm20620516d6.16.2026.03.06.11.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:27:34 -0800 (PST)
Date: Fri, 6 Mar 2026 14:27:32 -0500
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>, Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] eth fbnic: Add msix self test
Message-ID: <aasqpPj2rOIKgnSY@PF5YBGDS.localdomain>
References: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
 <20260305150947.16893-4-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305150947.16893-4-mike.marciniszyn@gmail.com>
X-Rspamd-Queue-Id: 8F1F32270C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264898-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.931];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,checkpatch.pl:url,PF5YBGDS.localdomain:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:09:45AM -0500, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
>
> This function is meant to test the global interrupt registers and the
> PCIe IP MSI-X functionality. It essentially goes through and tests
> various combinations of the set, clear, and mask bits in order to
> verify the behavior is as we expect it to be from the driver.
>
> Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
> ---
> v2 - add enum for test return codes
> v3 - add missing enum
>
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |  18 ++
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  28 ++++
>  drivers/net/ethernet/meta/fbnic/fbnic_irq.c   | 154 ++++++++++++++++++
>  3 files changed, 214 insertions(+)
>
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index 779a083b9215..534caa3c872d 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -194,6 +194,38 @@ void fbnic_synchronize_irq(struct fbnic_dev *fbd, int nr);
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
> + * @FBNIC_TEST_MSIX_BITS_SET_AFTER_TEST: Bits are set after test
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
> +	FBNIC_TEST_MSIX_BITS_SET_AFTER_TEST = 70,
> +};
> +
> +enum fbnic_msix_self_test_codes fbnic_msix_test(struct fbnic_dev *fbd);
> +
>  void fbnic_free_irqs(struct fbnic_dev *fbd);
>  int fbnic_alloc_irqs(struct fbnic_dev *fbd);
>
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 2e882dbd408d..b0c8d1b069e2 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -128,10 +128,12 @@ static const struct fbnic_stat fbnic_gstrings_xdp_stats[] = {
>
>  enum fbnic_self_test_results {
>  	TEST_REG = 0,
> +	TEST_MSIX,
>  };
>
>  static const char fbnic_gstrings_self_test[][ETH_GSTRING_LEN] = {
>  	[TEST_REG]	= "Register test (offline)",
> +	[TEST_MSIX]	= "MSI-X Interrupt test (offline)",
>  };
>
>  #define FBNIC_TEST_LEN ARRAY_SIZE(fbnic_gstrings_self_test)
> @@ -1501,6 +1503,28 @@ static int fbnic_ethtool_regs_test(struct net_device *netdev, u64 *data)
>  	return !!*data;
>  }
>
> +/**
> + * fbnic_ethtool_msix_test - Verify behavior of NIC interrupts
> + * @netdev: netdev device to test
> + * @data: Pointer to results storage
> + *
> + * This function is meant to test the global interrupt registers and the
> + * PCIe IP MSI-X functionality. It essentially goes through and tests
> + * test various combinations of the set, clear, and mask bits in order to
> + * verify the behavior is as we expect it to be from the driver.
> + *
> + * Return: non-zero on failure.
> + **/
> +static int fbnic_ethtool_msix_test(struct net_device *netdev, u64 *data)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	struct fbnic_dev *fbd = fbn->fbd;
> +
> +	*data = fbnic_msix_test(fbd);
> +
> +	return !!*data;
> +}
> +
>  static void fbnic_self_test(struct net_device *netdev,
>  			    struct ethtool_test *eth_test, u64 *data)
>  {
> @@ -1508,6 +1532,7 @@ static void fbnic_self_test(struct net_device *netdev,
>
>  	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE)) {
>  		data[TEST_REG] = 0;
> +		data[TEST_MSIX] = 0;
>  		return;
>  	}
>
> @@ -1517,6 +1542,9 @@ static void fbnic_self_test(struct net_device *netdev,
>  	if (fbnic_ethtool_regs_test(netdev, &data[TEST_REG]))
>  		eth_test->flags |= ETH_TEST_FL_FAILED;
>
> +	if (fbnic_ethtool_msix_test(netdev, &data[TEST_MSIX]))
> +		eth_test->flags |= ETH_TEST_FL_FAILED;
> +
>  	if (if_running && netif_open(netdev, NULL)) {
>  		netdev_err(netdev,
>  			   "Failed to re-initialize hardware following test\n");
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
> index 02e8b0b257fe..44034d53112c 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
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

There is a change in the patchworks checkpatch test the wants to see this as:

test_data = kzalloc_obj(*test_data, GFP_KERNEL);

Unfortunately, the net-next repo does not yet have this api and doesn't
have the checkpatch and the new api that comes in:

Commit 070580b0b174 ("checkpatch: Suggest kmalloc_obj family for sizeof allocations")

This looks like the checkpatch.pl in the test is not from net-next/main.

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
> +			result = FBNIC_TEST_MSIX_BITS_SET_AFTER_TEST;
> +
> +		/* Free IRQ */
> +		fbnic_free_irq(fbd, i, test_data);
> +	}
> +
> +	kfree(test_data);
> +
> +	return result;
> +}
> +
>  void fbnic_napi_name_irqs(struct fbnic_dev *fbd)
>  {
>  	unsigned int i;
> --
> 2.43.0
>

