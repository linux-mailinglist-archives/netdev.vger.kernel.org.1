Return-Path: <netdev+bounces-119778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD70956EF4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E07C1F22F18
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C361FD7;
	Mon, 19 Aug 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DOE1Ktja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32674EEA5
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081930; cv=none; b=UIZ8E4Ct0uJEx8zM2r6jhnhUQjN6GMr1KxB96lq9snB6stbMxh4fs84Q/b9/s1eZhWHbSkhKwfgMFTlI0kEVXtGrd0+6Xq56fLPooYdfvEP1SlwQ+gB3Q3PjA+vhOFqXShjJ9Jt7qnZE9dzhKiX39bN44YtCYc6d7/u2cGmsk14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081930; c=relaxed/simple;
	bh=BLvxj+/0RCGbtc6CYfZNZBJt1VO9J2g+FP9SJ4HIHE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wkkxye8O7+sbWe81BxlsmSHq310CWsc/0oTQCACWItdHkHg95EKJ6tufSN3omfQUSsUHKTvJ3COKCa19lDCXcXCviZe90iJpKNJUw+cwj3sIoxkpA+0RmO0vAih9hmsgVd8ZLVrsYkk51+huPnaRWmIbImqHBR4oougpBEknmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DOE1Ktja; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WncFd0j7DzHbv;
	Mon, 19 Aug 2024 17:38:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724081924;
	bh=TjcDKweBLObPuBGnmTc+trsNMm+NkLsfMLYl1jX+OBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOE1KtjankLRBcB9+v9cbONG/bKb6ZsC2+PXUknInd7BfX13JfEb2Ski1/G26Y2Lm
	 B0nI0DybN48kYlcyMvGtsAeDofr+kKpWzp4L/GUhclFBCs+rR+I5+piXMhNnEroT4+
	 fAKQmJV04XmPMkej8yteSvDmj8/W6e39SmIPPvDs=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WncFc3fMGzFlf;
	Mon, 19 Aug 2024 17:38:44 +0200 (CEST)
Date: Mon, 19 Aug 2024 17:38:41 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 2/5] selftests/Landlock: Abstract unix socket
 restriction tests
Message-ID: <20240819.jooTheeng2Ah@digikod.net>
References: <cover.1723615689.git.fahimitahera@gmail.com>
 <2fb401d2ee04b56c693bba3ebac469f2a6785950.1723615689.git.fahimitahera@gmail.com>
 <20240816.His9oihaigei@digikod.net>
 <Zr/b6j5V2IS4jpe8@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr/b6j5V2IS4jpe8@tahera-OptiPlex-5000>
X-Infomaniak-Routing: alpha

On Fri, Aug 16, 2024 at 05:08:26PM -0600, Tahera Fahimi wrote:
> On Fri, Aug 16, 2024 at 11:23:05PM +0200, Mickaël Salaün wrote:
> > Please make sure all subject's prefixes have "landlock", not "Landlock"
> > for consistency with current commits.
> > 
> > On Wed, Aug 14, 2024 at 12:22:20AM -0600, Tahera Fahimi wrote:
> > > The patch introduces Landlock ABI version 6 and has three types of tests
> > > that examines different scenarios for abstract unix socket connection:
> > > 1) unix_socket: base tests of the abstract socket scoping mechanism for a
> > >    landlocked process, same as the ptrace test.
> > > 2) optional_scoping: generates three processes with different domains and
> > >    tests if a process with a non-scoped domain can connect to other
> > >    processes.
> > > 3) unix_sock_special_cases: since the socket's creator credentials are used
> > >    for scoping sockets, this test examines the cases where the socket's
> > >    credentials are different from the process using it.
> > > 
> > > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > > ---
> > > Changes in versions:
> > > v9:
> > > - Move pathname_address_sockets to a different patch.
> > > - Extend optional_scoping test scenarios.
> > > - Removing hardcoded numbers and using "backlog" instead.
> > 
> > You may have missed some parts of my previous review (e.g. local
> > variables).
> Hi Mickaël,
> Thanks for the feedback. I actually did not apply the local variable for
> the reason below.
> > > V8:
> > > - Move tests to scoped_abstract_unix_test.c file.
> > > - To avoid potential conflicts among Unix socket names in different tests,
> > >   set_unix_address is added to common.h to set different sun_path for Unix sockets.
> > > - protocol_variant and service_fixture structures are also moved to common.h
> > > - Adding pathname_address_sockets to cover all types of address formats
> > >   for unix sockets, and moving remove_path() to common.h to reuse in this test.
> > > V7:
> > > - Introducing landlock ABI version 6.
> > > - Adding some edge test cases to optional_scoping test.
> > > - Using `enum` for different domains in optional_scoping tests.
> > > - Extend unix_sock_special_cases test cases for connected(SOCK_STREAM) sockets.
> > > - Modifying inline comments.
> > > V6:
> > > - Introducing optional_scoping test which ensures a sandboxed process with a
> > >   non-scoped domain can still connect to another abstract unix socket(either
> > >   sandboxed or non-sandboxed).
> > > - Introducing unix_sock_special_cases test which tests examines scenarios where
> > >   the connecting sockets have different domain than the process using them.
> > > V4:
> > > - Introducing unix_socket to evaluate the basic scoping mechanism for abstract
> > >   unix sockets.
> > > ---
> > >  tools/testing/selftests/landlock/base_test.c  |   2 +-
> > >  tools/testing/selftests/landlock/common.h     |  38 +
> > >  tools/testing/selftests/landlock/net_test.c   |  31 +-
> > >  .../landlock/scoped_abstract_unix_test.c      | 942 ++++++++++++++++++
> > >  4 files changed, 982 insertions(+), 31 deletions(-)
> > >  create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> > > 
> > 
> > > +static void create_unix_domain(struct __test_metadata *const _metadata)
> > > +{
> > > +	int ruleset_fd;
> > > +	const struct landlock_ruleset_attr ruleset_attr = {
> > > +		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
> > > +	};
> > > +
> > > +	ruleset_fd =
> > > +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> > > +	EXPECT_LE(0, ruleset_fd)
> > > +	{
> > > +		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
> > > +	}
> > > +	enforce_ruleset(_metadata, ruleset_fd);
> > > +	EXPECT_EQ(0, close(ruleset_fd));
> > > +}
> > > +
> > > +/* clang-format off */
> > 
> > It should not be required to add this clang-format comment here nor in
> > most places, except variant declarations (that might change if we remove
> > variables though).
> > 
> > > +FIXTURE(unix_socket)
> > > +{
> > > +	struct service_fixture stream_address, dgram_address;
> > > +	int server, client, dgram_server, dgram_client;
> > 
> > These variables don't need to be in the fixture but they should be local
> > instead (and scoped to the if/else condition where they are used).
> > 
> > > +};
> > > +
> > > +/* clang-format on */
> > > +FIXTURE_VARIANT(unix_socket)
> > > +{
> > > +	bool domain_both;
> > > +	bool domain_parent;
> > > +	bool domain_child;
> > > +	bool connect_to_parent;
> > > +};
> > 
> > > +/* 
> > > + * Test UNIX_STREAM_CONNECT and UNIX_MAY_SEND for parent and child,
> > > + * when they have scoped domain or no domain.
> > > + */
> > > +TEST_F(unix_socket, abstract_unix_socket)
> > > +{
> > > +	int status;
> > > +	pid_t child;
> > > +	bool can_connect_to_parent, can_connect_to_child;
> > > +	int err, err_dgram;
> > > +	int pipe_child[2], pipe_parent[2];
> > > +	char buf_parent;
> > > +
> > > +	/*
> > > +	 * can_connect_to_child is true if a parent process can connect to its
> > > +	 * child process. The parent process is not isolated from the child
> > > +	 * with a dedicated Landlock domain.
> > > +	 */
> > > +	can_connect_to_child = !variant->domain_parent;
> > > +	/*
> > > +	 * can_connect_to_parent is true if a child process can connect to its
> > > +	 * parent process. This depends on the child process is not isolated from
> > > +	 * the parent with a dedicated Landlock domain.
> > > +	 */
> > > +	can_connect_to_parent = !variant->domain_child;
> > > +
> > > +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> > > +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> > > +	if (variant->domain_both) {
> > > +		create_unix_domain(_metadata);
> > > +		if (!__test_passed(_metadata))
> > > +			return;
> > > +	}
> > > +
> > > +	child = fork();
> > > +	ASSERT_LE(0, child);
> > > +	if (child == 0) {
> > > +		char buf_child;
> > > +
> > > +		ASSERT_EQ(0, close(pipe_parent[1]));
> > > +		ASSERT_EQ(0, close(pipe_child[0]));
> > > +		if (variant->domain_child)
> > > +			create_unix_domain(_metadata);
> > > +
> > > +		/* Waits for the parent to be in a domain, if any. */
> > > +		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> > > +
> > > +		if (variant->connect_to_parent) {
> > > +			self->client = socket(AF_UNIX, SOCK_STREAM, 0);
> > 
> > int stream_client;
> > 
> > stream_client = socket(AF_UNIX, SOCK_STREAM, 0);
> > 
> > ditto for dgram_client
> > 
> > > +			self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
> > > +
> > > +			ASSERT_NE(-1, self->client);
> > > +			ASSERT_NE(-1, self->dgram_client);
> > > +			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> > > +
> > > +			err = connect(self->client,
> > > +				      &self->stream_address.unix_addr,
> > > +				      (self->stream_address).unix_addr_len);
> > > +			err_dgram =
> > > +				connect(self->dgram_client,
> > > +					&self->dgram_address.unix_addr,
> > > +					(self->dgram_address).unix_addr_len);
> > > +
> > > +			if (can_connect_to_parent) {
> > > +				EXPECT_EQ(0, err);
> > > +				EXPECT_EQ(0, err_dgram);
> > > +			} else {
> > > +				EXPECT_EQ(-1, err);
> > > +				EXPECT_EQ(-1, err_dgram);
> > > +				EXPECT_EQ(EPERM, errno);
> > > +			}
> > 
> > EXPECT_EQ(0, close(stream_client));
> > EXPECT_EQ(0, close(dgram_client));
> > 
> > > +		} else {
> > > +			self->server = socket(AF_UNIX, SOCK_STREAM, 0);
> > 
> > int stream_server;
> > 
> > server = socket(AF_UNIX, SOCK_STREAM, 0);
> > 
> > ditto for dgram_server
> > 
> > > +			self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
> > > +			ASSERT_NE(-1, self->server);
> > > +			ASSERT_NE(-1, self->dgram_server);
> > > +
> > > +			ASSERT_EQ(0,
> > > +				  bind(self->server,
> > > +				       &self->stream_address.unix_addr,
> > > +				       (self->stream_address).unix_addr_len));
> > > +			ASSERT_EQ(0, bind(self->dgram_server,
> > > +					  &self->dgram_address.unix_addr,
> > > +					  (self->dgram_address).unix_addr_len));
> > > +			ASSERT_EQ(0, listen(self->server, backlog));
> > > +
> > > +			/* signal to parent that child is listening */
> > > +			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
> > > +			/* wait to connect */
> > > +			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> > 
> > ditto
> > 
> > > +		}
> > > +		_exit(_metadata->exit_code);
> > > +		return;
> > > +	}
> > > +
> > > +	ASSERT_EQ(0, close(pipe_child[1]));
> > > +	ASSERT_EQ(0, close(pipe_parent[0]));
> > > +
> > > +	if (variant->domain_parent)
> > > +		create_unix_domain(_metadata);
> > > +
> > > +	/* Signals that the parent is in a domain, if any. */
> > > +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> > > +
> > > +	if (!variant->connect_to_parent) {
> > > +		self->client = socket(AF_UNIX, SOCK_STREAM, 0);
> > > +		self->dgram_client = socket(AF_UNIX, SOCK_DGRAM, 0);
> > 
> > ditto
> > 
> > > +
> > > +		ASSERT_NE(-1, self->client);
> > > +		ASSERT_NE(-1, self->dgram_client);
> > > +
> > > +		/* Waits for the child to listen */
> > > +		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> > > +		err = connect(self->client, &self->stream_address.unix_addr,
> > > +			      (self->stream_address).unix_addr_len);
> > > +		err_dgram = connect(self->dgram_client,
> > > +				    &self->dgram_address.unix_addr,
> > > +				    (self->dgram_address).unix_addr_len);
> > > +
> > > +		if (can_connect_to_child) {
> > > +			EXPECT_EQ(0, err);
> > > +			EXPECT_EQ(0, err_dgram);
> > > +		} else {
> > > +			EXPECT_EQ(-1, err);
> > > +			EXPECT_EQ(-1, err_dgram);
> > > +			EXPECT_EQ(EPERM, errno);
> > > +		}
> > > +		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> > 
> > ditto
> > 
> > > +	} else {
> > > +		self->server = socket(AF_UNIX, SOCK_STREAM, 0);
> > > +		self->dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
> > 
> > ditto
> > 
> > > +		ASSERT_NE(-1, self->server);
> > > +		ASSERT_NE(-1, self->dgram_server);
> > > +		ASSERT_EQ(0, bind(self->server, &self->stream_address.unix_addr,
> > > +				  (self->stream_address).unix_addr_len));
> > > +		ASSERT_EQ(0, bind(self->dgram_server,
> > > +				  &self->dgram_address.unix_addr,
> > > +				  (self->dgram_address).unix_addr_len));
> > > +		ASSERT_EQ(0, listen(self->server, backlog));
> > > +
> > > +		/* signal to child that parent is listening */
> > > +		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> > 
> > ditto
> I think if I define "server" and "dgram_server" as local variables, then
> in here, we should ensure that the clients connections are finished and
> then close the server sockets. The client can write on the pipe after the
> connection test is finished and then servers can close the sockets, but
> the current version is much easier. Simply when the test is finished,
> the FIXTURE_TEARDOWN closes all the sockets. What do you think about this?

Right, a close() call here would not work, but calling
close(stream_server) and close(dgram_server) at the end of this TEST_F()
will be OK and cleaner than in the teardown.  The scope of these
variable should then be TEST_F() too.

> > > +	}
> > > +
> > > +	ASSERT_EQ(child, waitpid(child, &status, 0));
> > > +
> > > +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> > > +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> > > +		_metadata->exit_code = KSFT_FAIL;
> > > +}
> > > +

