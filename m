Return-Path: <netdev+bounces-249309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE9D168C9
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 181EA300D818
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2C2EF673;
	Tue, 13 Jan 2026 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNcnXEJG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F52E9ECA;
	Tue, 13 Jan 2026 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275981; cv=none; b=LTdXkTnNw5vGETNTMFG4pzHDS+RgLMYbCE1+lOqF5G8HmX528clkkx2hbvK2p6KTpKbzknN3vNwaGpkqthaXYlzX1x53ufpUGidYWds8H41/SXqOSJF27fgUe/jgwBNByKEhAQp9CAOmHb6o33tx8llovPVQ0QsG86tkgO6BPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275981; c=relaxed/simple;
	bh=e8ar5iRaPWcIRipGAbsY+EJ9j4DyfXTRDnfzAz6mJSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zl0OU+7dRRxgBUHx6Z3+CIqcqee9QTANN8OTI/zilkbdYHCLMxLInwInsBnqc1rjYBT/ImgG612pfBo9gMNfO7PGy1hiJd7TP1zEbIBXnxwOs7SKhk22ySFq1DLkSJaEKbAXbKzCpu7fjOq4qvr91NLFRwvIrPWmzpH9TjMfs48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNcnXEJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B684CC116C6;
	Tue, 13 Jan 2026 03:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768275981;
	bh=e8ar5iRaPWcIRipGAbsY+EJ9j4DyfXTRDnfzAz6mJSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cNcnXEJGD+9i2sqchkDQeHfKczZ8BAYi4M/9RosqLwYz03V0EZt5p2+eceYAZd2V7
	 /8BiFiSddn+5Kt1PFe1xEr9lGa1ep1vJX3E1xJT9tx1C9e9fCtpgyeo1YX8MJQex95
	 8eOoNYvaTkt31ZSTzz/vsVJ5x1QgtAvHjIKed8zfE7K5F4DYnfN8RwU9L0hY57OvhU
	 pHXI+ti83sqliKVzxfhXVDtPxN/cViBq+FWqYW3gaFfeDmWLMP2Zn8BCnXeNbpwSW6
	 RIAJxaY2ht/6kBo7t0qDtzIHxO9bideDH7LNhV4vUGccIWm/9VHh0ngq0fe+GQbcGa
	 EaA1PROS8sOcw==
Date: Mon, 12 Jan 2026 19:46:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Chalios, Babis" <bchalios@amazon.es>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
 "mzxreary@0pointer.de" <mzxreary@0pointer.de>, "Cali, Marco"
 <xmarcalx@amazon.co.uk>, "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH v5 4/7] ptp: ptp_vmclock: Add device tree support
Message-ID: <20260112194619.70ed3a24@kernel.org>
In-Reply-To: <20260107132514.437-5-bchalios@amazon.es>
References: <20260107132514.437-1-bchalios@amazon.es>
	<20260107132514.437-5-bchalios@amazon.es>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 13:26:01 +0000 Chalios, Babis wrote:
> +static int vmclock_setup_notification(struct device *dev,
> +				      struct vmclock_state *st)
> +{
> +	/* The device does not support notifications. Nothing else to do */
> +	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
> +		return 0;
> +
> +	if (has_acpi_companion(dev)) {
> +		return vmclock_setup_acpi_notification(dev);
> +	} else {
> +		return vmclock_setup_of_notification(dev);
> +	}
> +
> +}
> +
> +
>  static void vmclock_put_idx(void *data)

Please run checkpatch.

CHECK: Blank lines aren't necessary before a close brace '}'
#109: FILE: drivers/ptp/ptp_vmclock.c:636:
+
+}

CHECK: Please don't use multiple blank lines
#111: FILE: drivers/ptp/ptp_vmclock.c:638:
+
+

